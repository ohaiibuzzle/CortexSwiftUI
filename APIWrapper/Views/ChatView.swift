//
//  ContentView.swift
//  llamacppWrapper
//
//  Created by Venti on 2/2/25.
//

import SwiftUI
import Combine
import MarkdownUI

struct MessageView: View {
    @StateObject var message: Message
    
    var body: some View {
        HStack {
            if message.role == MessageRole.user {
                Spacer()
                VStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                        Text("You:")
                            .bold()
                    }
                    HStack {
                        Spacer()
                        Text(message.content)
                            .textSelection(.enabled)
                    }
                }
                .padding()
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Assistant:")
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Markdown(message.content)
                            .textSelection(.enabled)
                        Spacer()
                    }
                }
                .padding()
            }
        }
        .padding(.horizontal)
    }
}

struct ChatView: View {
    @StateObject var chat: Chat
    @State private var message = ""
    @State private var isLoading = false
    
    @Binding var titleChanged: Bool
    
    var body: some View {
        VStack {
            if chat.messages.isEmpty{
                Spacer()
                Section {
                    Text("Send a message to start")
                }
            } else {
                ScrollViewReader { scrollView in
                    ScrollView {
                        LazyVStack {
                        ForEach(chat.messages, id: \.id) { message in
                            MessageView(message: message)
                                .padding(.horizontal)
                                .id(message.id)
                            Divider()
                        }
                        .padding(.top)
                        
                        HStack {
                            Spacer()
                            Button {
                                withAnimation {
                                    scrollView.scrollTo(chat.messages.first?.id)
                                }
                            } label: {
                                Image(systemName: "arrow.up.circle.fill")
                            }
                            .buttonStyle(.borderless)
                            .padding([.horizontal, .bottom], 25)
                        }
                        .id("bottom")
                        }
                    }
                    .onChange(of: chat.messages) {
                        withAnimation {
                            scrollView.scrollTo("bottom")
                        }
                    }
                    .onChange(of: isLoading) {
                        withAnimation {
                            scrollView.scrollTo("bottom")
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.1))
                    )
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            VStack {
                Section {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(LinearProgressViewStyle())
                    } else {
                        HStack {
                            TextField("Enter your message" ,text: $message)
                                .onSubmit(sendMessage)
                            Button {
                                sendMessage()
                            } label: {
                                Image(systemName: "paperplane.fill")
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(message.isEmpty)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
        .background(Color.gray.opacity(0.1))
    }
    
    private func sendMessage() {
        if message.isEmpty {
            return
        }

        if chat.messages.isEmpty {
            chat.title = message
            titleChanged.toggle()
        }
        
        let newMessage = Message(role: MessageRole.user, content: message)
        withAnimation{
            message = ""
            chat.messages.append(newMessage)
            chat.messages.append(Message(role: MessageRole.assistant, content: "Thinking... "))
        }
        
        Task(priority: .userInitiated) {
            withAnimation {
                isLoading.toggle()
            }
            let newMessage = Message(role: MessageRole.assistant, content: "")
            chat.messages.removeLast()
            chat.messages.append(newMessage)
            
            do {
                let response = try await OpenAIAPI.shared.streamChatCompletion(messages: chat.messages)
                // Response is a AsyncThrowingStream
                for try await response in response {
                    newMessage.content += response.choices.first?.delta.content ?? ""
                }
            } catch {
                print(error)
            }
            withAnimation {
                isLoading.toggle()
            }
            ChatList.shared.save()
        }
    }
}

#Preview {
    ChatView(chat: Chat(),titleChanged: .constant(false))
}
