//
//  OAIAPI.swift
//  llamacppWrapper
//
//  Created by Venti on 2/2/25.
//

import Foundation
import Combine

class OpenAIAPI {
    static let shared = OpenAIAPI()
    
    private let settings = ServerSettings.shared

    func getChatCompletion(messages: [Message]) async throws -> ChatCompletionResponse {
        let url = URL(string: settings.apiBaseUrl + "/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(settings.apiKey)", forHTTPHeaderField: "Authorization")

        let body: [String: Any] = [
            "messages": messages.map { [
                "role": $0.role.rawValue,
                "content": $0.content
            ] },
            "model": settings.model
        ]

        let jsonData = try JSONSerialization.data(withJSONObject: body)
        request.httpBody = jsonData
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(ChatCompletionResponse.self, from: data)
    }  

    func createStreamingRequest(messages: [Message]) throws -> URLRequest {
        let url = URL(string: settings.apiBaseUrl + "/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(settings.apiKey)", forHTTPHeaderField: "Authorization")

        // Construct the request body 
        let body: [String: Any] = [
            "messages": messages.map { [
                "role": $0.role.rawValue,
                "content": $0.content
            ] },
            "stream": true,
            "model": settings.model
        ]

        let jsonData = try JSONSerialization.data(withJSONObject: body)
        request.httpBody = jsonData
        return request
    }

    func parseStreamingResponse(line: String) throws -> StreamingChatCompletionResponse? {
        let components = line.split(separator: ":", maxSplits: 1, omittingEmptySubsequences: true)
        guard components.count == 2, components[0] == "data" else { return nil }
        
        let message = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
        
        if message == "[DONE]" {
            return nil
        } else {
            return try JSONDecoder().decode(StreamingChatCompletionResponse.self, from: message.data(using: .utf8)!)
        }
    }

    func streamChatCompletion(messages: [Message]) async throws -> AsyncThrowingStream<StreamingChatCompletionResponse, Error> {
        let request = try createStreamingRequest(messages: messages)
        let (stream, _) = try await URLSession.shared.bytes(for: request)

        return AsyncThrowingStream { continuation in
            Task.detached {
                for try await line in stream.lines {
                    do {
                        if let response = try self.parseStreamingResponse(line: line) {
                            continuation.yield(response)
                        }
                    } catch {
                        print(error.localizedDescription)
                        continuation.finish(throwing: error)
                    }
                }
                continuation.finish()
            }
        }
    }

    func getModels() async throws -> ModelListResponse {
        let url = URL(string: settings.apiBaseUrl + "/models")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(ModelListResponse.self, from: data)
    }
}
