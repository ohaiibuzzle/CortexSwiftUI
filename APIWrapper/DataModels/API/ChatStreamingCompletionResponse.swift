// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let streamingChatCompletionResponse = try? JSONDecoder().decode(StreamingChatCompletionResponse.self, from: jsonData)

import Foundation

// MARK: - StreamingChatCompletionResponseElement
struct StreamingChatCompletionResponse: Codable {
    let choices: [StreamingChoice]
    let created: Int?
    let id: String?
    let model: String?
    let systemFingerprint: String?
    let object: String?
    let usage: StreamingUsage?
    let timings: StreamingTimings?

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

// MARK: - StreamingChoice
struct StreamingChoice: Codable {
    let finishReason: String?
    let index: Int
    let delta: StreamingDelta

    enum CodingKeys: String, CodingKey {
        case finishReason = "finish_reason"
        case index = "index"
        case delta = "delta"
    }
}

// MARK: - StreamingDelta
struct StreamingDelta: Codable {
    let content: String?

    enum CodingKeys: String, CodingKey {
        case content = "content"
    }
}

// MARK: - StreamingTimings
struct StreamingTimings: Codable {
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

// MARK: - StreamingUsage
struct StreamingUsage: Codable {
    let completionTokens: Int
    let promptTokens: Int
    let totalTokens: Int

    enum CodingKeys: String, CodingKey {
        case completionTokens = "completion_tokens"
        case promptTokens = "prompt_tokens"
        case totalTokens = "total_tokens"
    }
}

