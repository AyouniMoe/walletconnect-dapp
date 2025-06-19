//
//  WebView.swift
//  WalletConnectV2Test
//
//  Created by Mohamad Alayouni on 6/9/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Reload if URL changes
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url, url.scheme == "metamask" {
                // Handle MetaMask deep links
                UIApplication.shared.open(url, options: [:]) { success in
                    if !success {
                        print("Failed to open MetaMask app. Ensure MetaMask is installed.")
                    }
                }
                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
        }
    }
}
