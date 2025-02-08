//
//  llamacppWrapperApp.swift
//  llamacppWrapper
//
//  Created by Venti on 2/2/25.
//

import SwiftUI

@main
struct APIWrapperApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
#if os(macOS)
        MenuBarExtra("API Wrapper", systemImage: "ellipsis.message") {
            MenuBarView()
                .padding()
        }
        .menuBarExtraStyle(.window)
#endif
    }
}
