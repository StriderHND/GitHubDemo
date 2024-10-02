//
//  APIEnum.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 2/10/24.
//

import Foundation

enum APIs {

    enum GitHub: String, API {
        static var baseURL: URL {
            guard let urlString = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String,
                  let url = URL(string: urlString) else {
                fatalError("BaseURL is not set correctly in the Info.plist or is not a valid URL.")
            }
            return url
        }

        // MARK: - API Users
        case users = "/users"
    }
}
