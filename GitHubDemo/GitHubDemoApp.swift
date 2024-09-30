//
//  GitHubDemoApp.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 30/9/24.
//

import SwiftUI

@main
struct GitHubDemoApp: App {
    @StateObject private var dataStore = GitHubDataStore()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(dataStore)
        }
    }
}
