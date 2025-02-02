//
//  SettingsSheet.swift
//  llamacppWrapper
//
//  Created by Venti on 5/2/25.
//

import SwiftUI

struct SettingsSheet: View {
    var settings = ServerSettings.shared
    
    @Binding var settingsShown: Bool
    
    @State private var apiKey = ""
    @State private var apiBaseUrl = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .font(.title)
                .bold()
            Divider()
            Section {
                VStack(alignment: .leading) {
                    Text("Server Settings")
                        .bold()
                    TextField("API Key", text: $apiKey)
                    TextField("Base URL", text: $apiBaseUrl)
                }
                .onAppear {
                    apiKey = settings.apiKey
                    apiBaseUrl = settings.apiBaseUrl
                }
            }
            Divider()
            Spacer()
            Section {
                HStack {
                    Spacer()
                    Button("Close") {
                        settingsShown = false
                        settings.apiKey = apiKey
                        settings.apiBaseUrl = apiBaseUrl
                    }
                    Spacer()
                }
            }
        }
        .padding()
    }
}

#Preview {
    SettingsSheet(settingsShown: .constant(true))
}
