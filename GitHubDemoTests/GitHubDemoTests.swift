//
//  GitHubDemoTests.swift
//  GitHubDemoTests
//
//  Created by Erick Gonzales on 30/9/24.
//

import XCTest
@testable import GitHubDemo

@MainActor
final class GitHubDataStoreTests: XCTestCase {

    var dataStore: GitHubDataStore!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        dataStore = GitHubDataStore(networkManager: mockNetworkManager)
    }

    override func tearDown() {
        dataStore = nil
        mockNetworkManager = nil
        super.tearDown()
    }

    func testFetchUsersSuccess() async {
        // Given
        mockNetworkManager.shouldReturnError = false

        // When
        await dataStore.fetchUsers()

        // Then
        XCTAssertEqual(dataStore.users.count, 2)
        XCTAssertEqual(dataStore.users.first?.login, "mockuser1")
        XCTAssertNil(dataStore.error)
    }

    func testFetchUsersFailure() async {
        // Given
        mockNetworkManager.shouldReturnError = true

        // When
        await dataStore.fetchUsers()

        // Then
        XCTAssertTrue(dataStore.users.isEmpty)
        XCTAssertNotNil(dataStore.error)
        XCTAssertEqual(dataStore.error?.code, 500)
    }

    func testFetchUserDataSuccess() async {
        // Given
        mockNetworkManager.shouldReturnError = false
        let username = "mockuser1"

        // When
        await dataStore.fetchUserData(username: username)

        // Then
        XCTAssertNotNil(dataStore.userDetail)
        XCTAssertEqual(dataStore.userDetail?.login, username)
        XCTAssertEqual(dataStore.repositories.count, 2)
        XCTAssertNil(dataStore.error)
    }

    func testFetchUserDataFailure() async {
        // Given
        mockNetworkManager.shouldReturnError = true
        let username = "mockuser1"

        // When
        await dataStore.fetchUserData(username: username)

        // Then
        XCTAssertNil(dataStore.userDetail)
        XCTAssertTrue(dataStore.repositories.isEmpty)
        XCTAssertNotNil(dataStore.error)
        XCTAssertEqual(dataStore.error?.code, 500)
    }

    func testClearUserData() {
        // Given
        dataStore.userDetail = UserDetail(login: "mockuser", name: "Mock User", followers: 10, following: 5, avatarUrl: "https://example.com/avatar.png")
        dataStore.repositories = [
            Repository(id: 1, name: "Repo1", language: "Swift", stargazersCount: 10, description: "Test Repo", htmlUrl: "https://github.com/mockuser/repo1", fork: false)
        ]

        // When
        dataStore.clearUserData()

        // Then
        XCTAssertNil(dataStore.userDetail)
        XCTAssertTrue(dataStore.repositories.isEmpty)
    }
}

