//
//  NetworkManager.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 30/9/24.
//

import Foundation
import OSLog

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

struct APIError: Error, LocalizedError, Identifiable {
    let id = UUID()
    let code: Int
    let type: String
    let message: String

    var errorDescription: String? {
        return message
    }
}

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    private let gitHubToken = "YOUR TOKEN HERE"

    private init() {}

    func request<T: Decodable>(
        _ endpoint: String,
        method: HTTPMethod = .GET,
        parameters: [String: Any]? = nil
    ) async throws -> T {
        var urlComponents = URLComponents(string: "\(APIs.GitHub.baseURL.absoluteString)\(endpoint)")

        // Add parameters as query items for GET requests
        if method == .GET, let parameters = parameters {
            var queryItems = urlComponents?.queryItems ?? []
            for (key, value) in parameters {
                let valueString = "\(value)"
                queryItems.append(URLQueryItem(name: key, value: valueString))
            }
            urlComponents?.queryItems = queryItems
        }

        // Validate URL
        guard let url = urlComponents?.url else {
            let errorMessage = "Invalid URL: \(endpoint)"
            Log.error(errorMessage)
            throw APIError(code: -1, type: "Invalid URL", message: errorMessage)
        }

        // Prepare request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("token \(gitHubToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        // Add parameters for POST, PUT, DELETE methods
        if method != .GET, let parameters = parameters {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }

        // Log the request
        Log.debug("Sending \(method.rawValue) request to \(url.absoluteString)")

        do {
            // Perform network request
            let (data, response) = try await URLSession.shared.data(for: request)

            // Handle HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                let errorMessage = "No response received from the server."
                Log.error(errorMessage)
                throw APIError(code: -1, type: "No Response", message: errorMessage)
            }

            Log.debug("Received HTTP status code: \(httpResponse.statusCode)")

            switch httpResponse.statusCode {
            case 200...299:
                // Decode response data
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    Log.debug("Successfully decoded response for \(url.absoluteString)")
                    return decodedResponse
                } catch {
                    let errorMessage = "Decoding error: \(error.localizedDescription)"
                    Log.error(errorMessage)
                    throw APIError(code: httpResponse.statusCode, type: "Decoding Error", message: errorMessage)
                }
            default:
                // Handle HTTP errors
                let message = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                Log.error("HTTP Error (\(httpResponse.statusCode)): \(message)")
                throw APIError(code: httpResponse.statusCode, type: "HTTP Error", message: message)
            }
        } catch {
            let errorMessage = "Network request failed: \(error.localizedDescription)"
            Log.error(errorMessage)
            throw error
        }
    }
}
