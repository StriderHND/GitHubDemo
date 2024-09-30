//
//  View+.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 1/10/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
