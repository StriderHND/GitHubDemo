//
//  UserListView.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 30/9/24.
//

import SwiftUI

struct UserListView: View {
    @EnvironmentObject var dataStore: GitHubDataStore
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        List(selection: horizontalSizeClass == .regular ? $dataStore.selectedUser : .constant(nil)) {
            ForEach(dataStore.users) { user in
                UserRow(user: user)
                    .onAppear {
                        if user == dataStore.users.last {
                            Task {
                                await dataStore.fetchUsers()
                            }
                        }
                    }
                    .if(horizontalSizeClass == .compact) { view in
                        NavigationLink(destination: UserDetailView(user: user)) {
                            view
                        }
                    }
                    .if(horizontalSizeClass == .regular) { view in
                        view.tag(user)
                    }
            }
            // Display a loading indicator at the bottom
            if dataStore.isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
        .navigationTitle("GitHub Users")
    }
}

