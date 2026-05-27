//
//  Background.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/1/26.
//

import SwiftUI

struct Background: View {
    var body: some View {
        MeshGradient(
            width: 2,
            height: 2,
            points: [
                [0, 0], [1, 0], [0, 1], [1, 1],
            ],
            colors: [
                Color(hex: "#f8aaa6"), .white, .white, Color(hex: "#f8aaa6"),
            ]
        )
        .ignoresSafeArea()
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let r, g, b: UInt64
        (r, g, b) = ((int >> 16) & 255, (int >> 8) & 255, int & 255)

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }
}

#Preview {
    Background()
}

