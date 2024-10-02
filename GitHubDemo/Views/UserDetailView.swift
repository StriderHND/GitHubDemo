//
//  UserDetailView.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 30/9/24.
//

import SwiftUI

import SwiftUI

struct UserDetailView: View {
    @EnvironmentObject var dataStore: GitHubDataStore
    @State private var selectedRepositoryURL: String?
    var user: User?

    var body: some View {
        VStack {
            if let user = user ?? dataStore.selectedUser {
                if let userDetail = dataStore.userDetail, userDetail.login == user.login {
                    // Display user details
                    VStack(alignment: .leading) {
                        HStack {
                            AsyncImage(url: URL(string: userDetail.avatarUrl)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())

                            VStack(alignment: .leading) {
                                Text(userDetail.name ?? userDetail.login)
                                    .font(.title)
                                Text("@\(userDetail.login)")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()

                        HStack {
                            Text("Followers: \(userDetail.followers)")
                            Spacer()
                            Text("Following: \(userDetail.following)")
                        }
                        .padding([.leading, .trailing, .bottom])
                    }

                    // Display repositories
                    List(dataStore.repositories) { repo in
                        Button(action: {
                            selectedRepositoryURL = repo.htmlUrl
                        }) {
                            RepositoryRow(repository: repo)
                        }
                    }
                } else {
                    // Show progress view while data is loading
                    ProgressView()
                        .onAppear {
                            Task {
                                await dataStore.fetchUserData(username: user.login)
                            }
                        }
                }
            } else {
                Text("Select a user")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle(user?.login ?? dataStore.userDetail?.login ?? "")
        .sheet(item: $selectedRepositoryURL) { url in
                    RepositoryWebView(url: url)
                }
        .onDisappear {
            dataStore.clearUserData()
        }
    }
}
