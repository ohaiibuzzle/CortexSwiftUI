//
//  ContentView.swift
//  llamacppWrapper
//
//  Created by Venti on 2/2/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: UUID?
    @State private var settingsShown = false
    @StateObject var chatList = ChatList.shared
    @State var settings = ServerSettings.shared
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(chatList.chats) { chat in
                    NavigationLink(value: chat.id) {
                        Text(chat.title)
                    }
                }
                .id(chatList.needsUpdate)
            }
        } detail: {
            ZStack {
                if let selection {
                    let chat = chatList.chats.first(where: { $0.id == selection })!
                    ChatView(chat: chat, titleChanged: $chatList.needsUpdate)
                        .navigationTitle(chat.title)
                        .id(selection)
                }
                else {
                    Text("Select a chat")
                        .id(UUID())
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    Button {
                        chatList.newChat()
                        selection = chatList.chats.first?.id
                    } label: {
                        Image(systemName: "plus")
                    }
                    Button {
                        if let selection {
                            chatList.chats.removeAll(where: { $0.id == selection })
                        }
                        selection = chatList.chats.first?.id ?? nil
                    } label: {
                        Image(systemName: "trash")
                    }
                    Button {
                        settingsShown.toggle()
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
        }
        .navigationTitle("Chats")
        .onAppear() {
            selection = chatList.chats.first?.id
        }
        .sheet(isPresented: $settingsShown) {
            SettingsSheet(settingsShown: $settingsShown)
        }
    }
}

#Preview {
    ContentView()
}
