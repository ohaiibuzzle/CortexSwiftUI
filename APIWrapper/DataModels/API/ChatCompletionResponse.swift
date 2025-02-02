// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let chatCompletionResponse = try? JSONDecoder().decode(ChatCompletionResponse.self, from: jsonData)

import Foundation

// MARK: - ChatCompletionResponse
struct ChatCompletionResponse: Codable {
    let choices: [Choice]
    let created: Int
    let id: String
    let model: String
    let systemFingerprint: String
    let object: String
    let usage: Usage
    let timings: Timings

    enum CodingKeys: String, CodingKey {
        case choices = "choices"
        case created = "created"
        case id = "id"
        case model = "model"
        case systemFingerprint = "system_fingerprint"
        case object = "object"
        case usage = "usage"
        case timings = "timings"
    }
}

// MARK: - Choice
struct Choice: Codable {
    let finishReason: String
    let index: Int
    let delta: Delta

    enum CodingKeys: String, CodingKey {
        case finishReason = "finish_reason"
        case index = "index"
        case delta = "delta"
    }
}

// MARK: - Delta
struct Delta: Codable {
}

// MARK: - Timings
struct Timings: Codable {
    let promptN: Int
    let promptMS: Double
    let promptPerTokenMS: Double
    let promptPerSecond: Double
    let predictedN: Int
    let predictedMS: Double
    let predictedPerTokenMS: Double
    let predictedPerSecond: Double

    enum CodingKeys: String, CodingKey {
        case promptN = "prompt_n"
        case promptMS = "prompt_ms"
        case promptPerTokenMS = "prompt_per_token_ms"
        case promptPerSecond = "prompt_per_second"
        case predictedN = "predicted_n"
        case predictedMS = "predicted_ms"
        case predictedPerTokenMS = "predicted_per_token_ms"
        case predictedPerSecond = "predicted_per_second"
    }
}

// MARK: - Usage
struct Usage: Codable {
    let completionTokens: Int
    let promptTokens: Int
    let totalTokens: Int

    enum CodingKeys: String, CodingKey {
        case completionTokens = "completion_tokens"
        case promptTokens = "prompt_tokens"
        case totalTokens = "total_tokens"
    }
}
