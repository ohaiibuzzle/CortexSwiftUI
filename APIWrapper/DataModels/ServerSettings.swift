//
//  ServerSettings.swift
//  llamacppWrapper
//
//  Created by Venti on 5/2/25.
//

import Foundation
import SwiftUI

struct ServerSettings{
    static let shared = ServerSettings()

    @AppStorage("apiBaseUrl") var apiBaseUrl: String = "http://localhost:39281/v1"
    @AppStorage("apiKey") var apiKey: String = ""
    @AppStorage("model") var model: String = ""

    var modelStarted = false
}
