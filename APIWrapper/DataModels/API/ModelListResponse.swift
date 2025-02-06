//
//  ModelListResponse.swift
//  APIWrapper
//
//  Created by Venti on 6/2/25.
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let modelListResponse = try? JSONDecoder().decode(ModelListResponse.self, from: jsonData)

import Foundation

// MARK: - ModelListResponse
struct ModelListResponse: Codable {
    let data: [Datum]?
    let object: String?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case object = "object"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let cacheType: String?
    let cachingEnabled: Bool?
    let cpuThreads: Int?
    let ctxLen: Int?
    let engine: String?
    let flashAttn: Bool?
    let frequencyPenalty: Int?
    let grammarFile: String?
    let grpAttnN: Int?
    let grpAttnW: Int?
    let id: String?
    let maxTokens: Int?
    let mlock: Bool?
    let nBatch: Int?
    let ngl: Int?
    let prePrompt: String?
    let presencePenalty: Int?
    let promptTemplate: String?
    let recommendation: Recommendation?
    let size: Int?
    let stop: [String]?
    let stream: Bool?
    let temperature: Double?
    let topP: Double?
    let useMmap: Bool?

    enum CodingKeys: String, CodingKey {
        case cacheType = "cache_type"
        case cachingEnabled = "caching_enabled"
        case cpuThreads = "cpu_threads"
        case ctxLen = "ctx_len"
        case engine = "engine"
        case flashAttn = "flash_attn"
        case frequencyPenalty = "frequency_penalty"
        case grammarFile = "grammar_file"
        case grpAttnN = "grp_attn_n"
        case grpAttnW = "grp_attn_w"
        case id = "id"
        case maxTokens = "max_tokens"
        case mlock = "mlock"
        case nBatch = "n_batch"
        case ngl = "ngl"
        case prePrompt = "pre_prompt"
        case presencePenalty = "presence_penalty"
        case promptTemplate = "prompt_template"
        case recommendation = "recommendation"
        case size = "size"
        case stop = "stop"
        case stream = "stream"
        case temperature = "temperature"
        case topP = "top_p"
        case useMmap = "use_mmap"
    }
}

// MARK: - Recommendation
struct Recommendation: Codable {
    let cpuMode: CPUMode?
    let gpuMode: [GPUMode]?

    enum CodingKeys: String, CodingKey {
        case cpuMode = "cpu_mode"
        case gpuMode = "gpu_mode"
    }
}

// MARK: - CPUMode
struct CPUMode: Codable {
    let ram: Int?

    enum CodingKeys: String, CodingKey {
        case ram = "ram"
    }
}

// MARK: - GPUMode
struct GPUMode: Codable {
    let activated: Bool?
    let additionalInformation: AdditionalInformation?
    let freeVRAM: Int?
    let id: String?
    let name: String?
    let totalVRAM: Int?
    let uuid: String?
    let version: String?

    enum CodingKeys: String, CodingKey {
        case activated = "activated"
        case additionalInformation = "additional_information"
        case freeVRAM = "free_vram"
        case id = "id"
        case name = "name"
        case totalVRAM = "total_vram"
        case uuid = "uuid"
        case version = "version"
    }
}

// MARK: - AdditionalInformation
struct AdditionalInformation: Codable {
    let computeCap: String?
    let driverVersion: String?

    enum CodingKeys: String, CodingKey {
        case computeCap = "compute_cap"
        case driverVersion = "driver_version"
    }
}


struct ModelMapping: Hashable {
    let id: String
    let name: String
}

struct ModelMappings: Hashable {
    let models: [ModelMapping]

    init(from modelListResponse: [Datum]) {
        self.models = modelListResponse.map { ModelMapping(id: $0.id!, name: $0.id!) }
    }
}
