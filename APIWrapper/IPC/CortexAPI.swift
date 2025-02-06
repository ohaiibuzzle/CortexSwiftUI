//
//  CortexAPI.swift
//  APIWrapper
//
//  Created by Venti on 6/2/25.
//

import Foundation
import Combine
 
class CortexAPI {
    static let shared = CortexAPI()
    
    private var settings = ServerSettings.shared

    func startModel() async throws {
        let url = URL(string: settings.apiBaseUrl + "/models/start")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(settings.apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [
            "model": settings.model
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: body)
        request.httpBody = jsonData
        let (_, _) = try await URLSession.shared.data(for: request)

        settings.modelStarted = true
    }
}
