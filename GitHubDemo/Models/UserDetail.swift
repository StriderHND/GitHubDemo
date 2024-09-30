//
//  UserDetail.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 30/9/24.
//

import Foundation

struct UserDetail: Codable, Sendable {
    let login: String
    let name: String?
    let followers: Int
    let following: Int
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case login, name, followers, following
        case avatarUrl = "avatar_url"
    }
}
