# GitHub User Browser App

A simple iOS app built using **SwiftUI** and **iOS 17 APIs** that allows users to browse GitHub users and their repositories. The app features infinite scrolling, WebView integration, and error handling, making it easy to explore GitHub profiles.

## Features

- **User List:** Displays GitHub users with avatars and usernames.
- **User Detail Screen:** Provides detailed information such as the user's full name, followers/following, and a list of their repositories.
- **Repository List:** Displays non-forked repositories, including repository name, programming language, star count, and description.
- **WebView Integration:** Allows users to view repositories directly in the app using a WebView or Safari ViewController.
- **Infinite Scrolling:** Automatically loads more users as you scroll to the bottom of the list.
- **Error Handling:** Shows alert messages for network failures with detailed error descriptions.
- **Logging:** Provides debug and error logs for network requests and responses.

## Technologies Used

- **SwiftUI**: Modern declarative UI framework used for building the interface.
- **Swift Concurrency (async/await)**: For handling asynchronous network requests and pagination.
- **WebKit (WKWebView)**: For displaying repository details in the app.
- **SFSafariViewController**: For simplified web viewing of repositories.
- **GitHub REST API**: Used to fetch users and repositories.
- **OSLog**: Custom logging system for network requests and debugging.

## Architecture

- **MVVM (Model-View-ViewModel)**: The app follows the MVVM architecture to separate UI logic from business logic.
  - **Model**: Represents the data fetched from the GitHub API (e.g., `User`, `UserDetail`, `Repository`).
  - **ViewModel**: Handles data fetching and state management (`GitHubDataStore`).
  - **View**: SwiftUI views that render the UI (e.g., `UserListView`, `UserDetailView`).
- **Network Layer**: A reusable `NetworkManager` class that handles all network requests, including GET and POST requests, and processes pagination for GitHub users.

## OS Support

- **iOS 17+**
  - The app takes advantage of iOS 17 APIs and SwiftUI enhancements, so it requires iOS 17 or later.
  - The app supports both iPhones and iPads with adaptive UI.

## Installation

### Prerequisites

- Xcode 15 or later
- iOS 17 simulator or device
- Swift 5.5+

### Steps

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/github-user-browser.git
   cd github-user-browser
   ```

2. **Open the project in Xcode:**

   ```bash
   open GitHubUserBrowser.xcodeproj
   ```

3. **Set up GitHub Personal Access Token:**

   The app uses a personal access token to make authenticated requests to the GitHub API. Replace the placeholder `YOUR_PERSONAL_ACCESS_TOKEN` in the `NetworkManager.swift` file with your actual GitHub token:

   ```swift
   private let gitHubToken = "YOUR_PERSONAL_ACCESS_TOKEN"
   ```

   You can create a personal access token from GitHub by following [this guide](https://docs.github.com/en/rest/quickstart).

4. **Build and run the app**:

   Select a simulator or a physical device and press `Command + R` to build and run the app.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---
