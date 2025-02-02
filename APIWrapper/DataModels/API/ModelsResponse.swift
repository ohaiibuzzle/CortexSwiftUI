//
//  ModelsResponse.swift
//  llamacppWrapper
//
//  Created by Venti on 2/2/25.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let modelsResponse = try? JSONDecoder().decode(ModelsResponse.self, from: jsonData)

import Foundation

// MARK: - ModelsResponse
struct ModelsResponse: Codable {
    let object: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id, object: String
    let created: Int
    let ownedBy: String
    let meta: Meta

    enum CodingKeys: String, CodingKey {
        case id, object, created
        case ownedBy = "owned_by"
        case meta
    }
}

// MARK: - Meta
struct Meta: Codable {
    let vocabType, nVocab, nCtxTrain, nEmbd: Int
    let nParams, size: Int

    enum CodingKeys: String, CodingKey {
        case vocabType = "vocab_type"
        case nVocab = "n_vocab"
        case nCtxTrain = "n_ctx_train"
        case nEmbd = "n_embd"
        case nParams = "n_params"
        case size
    }
}
