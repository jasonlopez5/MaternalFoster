//
//  HTMLContentView.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/3/26.
//

import SwiftUI
import WebKit

struct HTMLContentView: UIViewRepresentable {
    let html: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = true
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let styledHTML = """
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                body {
                    font-family: -apple-system;
                    font-size: 16px;
                    color: #222222;
                    line-height: 1.5;
                    margin: 0;
                    padding: 0;
                }

                h1, h2, h3, h4, h5 {
                    margin-top: 18px;
                    margin-bottom: 8px;
                }

                p {
                    margin-top: 8px;
                    margin-bottom: 8px;
                }

                ul {
                    padding-left: 22px;
                }

                li {
                    margin-bottom: 6px;
                }

                a {
                    color: #000000;
                    text-decoration: none;
                    font-weight: 600;
                }
            </style>
        </head>
        <body>
            \(html)
        </body>
        </html>
        """

        webView.loadHTMLString(styledHTML, baseURL: nil)
    }
}

#Preview {
    ZStack {
        Background()

        HTMLContentView(html: """
        <h2>Warning Signs During Pregnancy</h2>
        <p>Some symptoms during pregnancy may need medical attention.</p>
        <ul>
            <li>Severe headache</li>
            <li>Chest pain</li>
            <li>Trouble breathing</li>
            <li>Heavy bleeding</li>
        </ul>
        <p><a href="https://www.cdc.gov">Learn more from CDC</a></p>
        """)
        .frame(height: 350)
        .padding()
        .background(Color(hex: "#fde2e4"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
    }
}
