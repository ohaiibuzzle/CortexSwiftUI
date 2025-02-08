//
//  MenuBarView.swift
//  APIWrapper
//
//  Created by Venti on 8/2/25.
//

import SwiftUI

struct MenuBarView: View {
    @State private var chat = Chat()
    @State private var isBeingReset = false
    
    @State var model: String = ServerSettings.shared.model
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Using model: " + model)
                Spacer()
                Button {
                    isBeingReset.toggle()
                    Task {
                        self.chat = Chat()
                        sleep(1)
                        isBeingReset.toggle()
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
            .padding([.horizontal, .bottom])
            if isBeingReset {
                Spacer()
                HStack() {
                    Spacer()
                    ProgressView()
                        .controlSize(.small)
                    Spacer()
                }
                Spacer()
            } else {
                ChatView(chat: chat, titleChanged: .constant(false), heightReduced: true)
            }
        }
        .frame(width: 500, height: 400)
    }
}
