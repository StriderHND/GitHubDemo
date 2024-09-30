//
//  RootView.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 30/9/24.
//

import SwiftUI

import SwiftUI

struct RootView: View {
    @EnvironmentObject var dataStore: GitHubDataStore
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        Group {
            if horizontalSizeClass == .compact {
                NavigationView {
                    UserListView()
                }
                .navigationViewStyle(StackNavigationViewStyle())
            } else {
                NavigationSplitView {
                    UserListView()
                } detail: {
                    UserDetailView()
                }
            }
        }
        .onAppear {
            Task {
                await dataStore.fetchUsers()
            }
        }
        .errorAlert(error: $dataStore.error)
    }
}

#Preview {
    RootView()
}
