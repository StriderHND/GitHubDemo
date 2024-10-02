//
//  NetworkManagerProtocol.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 1/10/24.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(_ endpoint: String, method: HTTPMethod, parameters: [String: Any]?) async throws -> T
}
