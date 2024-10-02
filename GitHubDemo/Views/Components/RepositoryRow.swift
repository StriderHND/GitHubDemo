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
                .foregroundColor(.primary)
            Text(repository.description ?? "")
                .font(.subheadline)
                .foregroundColor(.secondary)
            HStack {
                if let language = repository.language {
                    Text(language)
                }
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                Text("\(repository.stargazersCount)")
                    .foregroundColor(.primary)
            }
            .font(.caption)
        }
        .padding(.vertical, 5)
    }
}
