//
//  Chat.swift
//  llamacppWrapper
//
//  Created by Venti on 2/2/25.
//

import Foundation

enum MessageRole: String, Codable {
    case user = "user"
    case assistant = "assistant"
    case system = "developer"
}

class Message: Identifiable, Hashable, ObservableObject, Codable {
    var id: UUID = UUID()
    var role: MessageRole = .user
    @Published var content: String = ""
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(role: MessageRole, content: String) {
        self.role = role
        self.content = content
    }

    enum CodingKeys: String, CodingKey {
        case id
        case role
        case content
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.role = try container.decode(MessageRole.self, forKey: .role)
        self.content = try container.decode(String.self, forKey: .content)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(role, forKey: .role)
        try container.encode(content, forKey: .content)
    }
}

// Struct for all conversations
class Chat: Identifiable, ObservableObject, Codable {
    @Published var id: UUID
    @Published var title: String
    @Published var messages: [Message]

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case messages
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.messages = try container.decode([Message].self, forKey: .messages)
    }

    init () {
        self.id = UUID()
        self.title = "New Chat"
        self.messages = []
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(messages, forKey: .messages)
    }
}
