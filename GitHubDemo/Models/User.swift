//
//  Users.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 30/9/24.
//

import Foundation

struct User: Codable, Identifiable, Hashable, Sendable {
    let id: Int
    let login: String
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case id, login
        case avatarUrl = "avatar_url"
    }
}
