//
//  ContentView.swift
//  WalletConnectV2Test
//
//  Created by Mohamad Alayouni on 6/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let path = Bundle.main.path(forResource: "walletconnect", ofType: "html")
        if let path = path {
            let url = URL(fileURLWithPath: path).appending(queryItems: [URLQueryItem(name: "mintToken", value: "test-uuid")])
            print("Loading HTML: \(url.absoluteString)")
            return AnyView(
                WebView(url: url)
                    .edgesIgnoringSafeArea(.all)
            )
        } else {
            print("Error: walletconnect.html not found in bundle")
            return AnyView(
                Text("Error: HTML file not found")
                    .foregroundColor(.red)
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

#Preview {
    ContentView()
}
