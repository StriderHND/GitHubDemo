//
//  RawRepresentable+.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 2/10/24.
//

import Foundation

extension RawRepresentable where RawValue == String, Self: API {
    var url: URL { Self.baseURL.appendingPathComponent(rawValue) }
}
