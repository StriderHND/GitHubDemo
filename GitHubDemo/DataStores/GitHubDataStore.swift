//
//  GitHubDataStore.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 30/9/24.
//

import Foundation

@MainActor
final class GitHubDataStore: ObservableObject {
    // Properties
    @Published var users: [User] = []
    @Published var selectedUser: User?
    @Published var userDetail: UserDetail?
    @Published var repositories: [Repository] = []
    @Published var error: APIError?

    // Pagination properties
    private var since: Int?
    @Published var isLoading = false
    private var hasMoreUsers = true

    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
}


// MARK: - Public Functions
extension GitHubDataStore {
    // Methods
    func fetchUsers() async {
        guard !isLoading && hasMoreUsers else { return }
        isLoading = true
        Log.info("Starting fetchUsers with since: \(since ?? 0)")
        do {
            let parameters: [String: Any] = ["since": since ?? 0, "per_page": 30]
            let newUsers: [User] = try await networkManager.request(
                APIs.GitHub.users.rawValue, method: .GET,
                parameters: parameters
            )

            if newUsers.isEmpty {
                hasMoreUsers = false
            } else {
                self.users.append(contentsOf: newUsers)
                // Update 'since' with the last user's ID
                since = newUsers.last?.id
                Log.info("Fetched \(newUsers.count) users, since updated to \(since ?? 0)")
            }
        } catch let apiError as APIError {
            self.error = apiError
            Log.error("APIError in fetchUsers: \(apiError.message)")
        } catch {
            self.error = APIError(code: -1, type: "Unknown Error", message: error.localizedDescription)
            Log.error("Unknown error in fetchUsers: \(error.localizedDescription)")
        }
        isLoading = false
    }

    func fetchUserData(username: String) async {
        Log.info("Starting fetchUserData for user: \(username)")
        do {
            async let detail: UserDetail = NetworkManager.shared.request("\(APIs.GitHub.users.rawValue)/\(username)")
            async let repos: [Repository] = NetworkManager.shared.request("\(APIs.GitHub.users.rawValue)/\(username)/repos")
            let (userDetail, repositories) = try await (detail, repos)
            self.userDetail = userDetail
            self.repositories = repositories.filter { !$0.fork }
            Log.info("Successfully fetched data for user: \(username)")
        } catch let apiError as APIError {
            self.error = apiError
            Log.error("APIError in fetchUserData: \(apiError.message)")
        } catch {
            self.error = APIError(code: -1, type: "Unknown Error", message: error.localizedDescription)
            Log.error("Unknown error in fetchUserData: \(error.localizedDescription)")
        }
    }

    func clearUserData() {
        Log.info("Clearing user data")
        self.userDetail = nil
        self.repositories = []
    }
}

// MARK: - Private Punctions
fileprivate extension GitHubDataStore {

}
