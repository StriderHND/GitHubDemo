//
//  UserRow.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 1/10/24.
//

import SwiftUI

struct UserRow: View {
    let user: User

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.avatarUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())

            Text(user.login)
                .font(.headline)
        }
    }
}
