//
//  MockNetworkManager.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 1/10/24.
//
import Foundation

class MockNetworkManager: NetworkManagerProtocol {
    var shouldReturnError = false
    var responseData: [String: Any] = [:]

    func request<T>(_ endpoint: String, method: HTTPMethod = .GET, parameters: [String : Any]? = nil) async throws -> T where T : Decodable {
        if shouldReturnError {
            throw APIError(code: 500, type: "Internal Server Error", message: "Mock error")
        }

        // Return mock data based on the expected type T
        if T.self == [User].self {
            // Return an array of mock users
            let users = [
                User(id: 1, login: "mockuser1", avatarUrl: "https://example.com/avatar1.png"),
                User(id: 2, login: "mockuser2", avatarUrl: "https://example.com/avatar2.png")
            ]
            return users as! T
        } else if T.self == UserDetail.self {
            // Return a mock user detail
            let userDetail = UserDetail(login: "mockuser1", name: "Mock User One", followers: 10, following: 5, avatarUrl: "https://example.com/avatar1.png")
            return userDetail as! T
        } else if T.self == [Repository].self {
            // Return an array of mock repositories
            let repositories = [
                Repository(id: 1, name: "MockRepo1", language: "Swift", stargazersCount: 100, description: "A mock repository", htmlUrl: "https://github.com/mockuser1/mockrepo1", fork: false),
                Repository(id: 2, name: "MockRepo2", language: "Objective-C", stargazersCount: 50, description: "Another mock repository", htmlUrl: "https://github.com/mockuser1/mockrepo2", fork: false)
            ]
            return repositories as! T
        } else {
            fatalError("Unhandled type \(T.self)")
        }
    }
}
