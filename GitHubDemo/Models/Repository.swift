//
//  Repository.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 30/9/24.
//

struct Repository: Codable, Identifiable, Sendable {
    let id: Int
    let name: String
    let language: String?
    let stargazersCount: Int
    let description: String?
    let htmlUrl: String
    let fork: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, language, description, fork
        case stargazersCount = "stargazers_count"
        case htmlUrl = "html_url"
    }
}
