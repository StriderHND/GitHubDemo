//
//  RepositoryWebView.swift
//  GitHubDemo
//
//  Created by Erick Gonzales on 30/9/24.
//

import SwiftUI
import WebKit

struct RepositoryWebView: UIViewRepresentable {
    let url: String

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let link = URL(string: url) {
            let request = URLRequest(url: link)
            uiView.load(request)
        }
    }
}

