//
//  ErrorAlertModifier.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 30/9/24.
//

import SwiftUI

struct ErrorAlertModifier: ViewModifier {
    @Binding var error: APIError?

    func body(content: Content) -> some View {
        content
            .alert(item: $error) { error in
                Alert(
                    title: Text("\(error.code) \(error.type)"),
                    message: Text(error.localizedDescription),
                    dismissButton: .default(Text("OK")) {
                        self.error = nil
                    }
                )
            }
    }
}

extension View {
    func errorAlert(error: Binding<APIError?>) -> some View {
        self.modifier(ErrorAlertModifier(error: error))
    }
}
