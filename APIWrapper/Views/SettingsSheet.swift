//
//  SettingsSheet.swift
//  llamacppWrapper
//
//  Created by Venti on 5/2/25.
//

import SwiftUI

enum SettingsPages {
    case server
    case model
}

struct SettingsSheet: View {
    @Binding var settingsShown: Bool
    @State private var page: SettingsPages = .server
    
    var body: some View {
        NavigationStack {
            TabView(selection: $page) {
                SettingsView()
                    .tag(SettingsPages.server)
                    .tabItem { Label("Server", systemImage: "gear") }
                ModelView()
                    .tag(SettingsPages.model)
                    .tabItem { Label("Model", systemImage: "globe") }
            }
            .toolbar {
                Button("Done") {
                    settingsShown = false
                }
            }
        }
#if os(macOS)
        .padding()
#endif
    }
    
    struct SettingsView: View {
        @State private var apiKey = ServerSettings.shared.apiKey
        @State private var apiBaseUrl = ServerSettings.shared.apiBaseUrl
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("Server Settings")
                    .font(.title)
                    .bold()
                    .padding()
                Form {
                    Group {
                        TextField("Base URL", text: $apiBaseUrl)
                        TextField("API Key", text: $apiKey)
                    }
                    .padding()
                }
            }
            .onDisappear {
                ServerSettings.shared.apiKey = apiKey
                ServerSettings.shared.apiBaseUrl = apiBaseUrl
            }
        }
    }
    
    struct ModelView: View {
        @State var model: String = ServerSettings.shared.model
        @State var modelList: [ModelMapping]?
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("Model Settings")
                    .font(.title)
                    .bold()
                    .padding()
                if modelList != nil {
                    Form {
                        Picker(selection: $model, label: Text("Model")) {
                            ForEach(modelList!, id: \.id) { model in
                                Text(model.name)
                                    .tag(model.id)
                            }
                            Text("None")
                                .tag("")
                        }
                        .pickerStyle(.menu)
                        .onChange(of: model) { oldModel, newModel in
                            ServerSettings.shared.model = newModel
                        }
                        .padding()
                    }
                } else {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .controlSize(.small)
                }
                Spacer()
            }
            .onAppear {
                Task.detached {
                    await fetchModels()
                    Task { @MainActor in
                        self.model = ServerSettings.shared.model
                    }
                }
            }
            .onDisappear {
                ServerSettings.shared.model = model
            }
        }
        private func fetchModels() async {
            do {
                let modelListResponse = try await OpenAIAPI.shared.getModels()
                Task { @MainActor in
                    self.modelList = ModelMappings(from: modelListResponse.data!).models
                }
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    SettingsSheet(settingsShown: .constant(true))
}
