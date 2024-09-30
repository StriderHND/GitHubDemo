//
//  RepositoryRow.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 30/9/24.
//

import SwiftUI

struct RepositoryRow: View {
    let repository: Repository

    var body: some View {
        VStack(alignment: .leading) {
            Text(repository.name)
                .font(.headline)
            Text(repository.description ?? "")
                .font(.subheadline)
                .foregroundColor(.secondary)
            HStack {
                if let language = repository.language {
                    Text(language)
                }
                Spacer()
                Image(systemName: "star.fill")
                Text("\(repository.stargazersCount)")
            }
            .font(.caption)
        }
        .padding(.vertical, 5)
    }
}
