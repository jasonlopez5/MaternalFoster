//
//  TopicCard.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/3/26.
//

import SwiftUI

struct TopicCard: View {
    let title: String
    let description: String
    let icon: String
    let iconColorHex: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(Color(hex: iconColorHex))
                .frame(width: 34, height: 34)
                .background(.clear)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.black)

                Text(description)
                    .font(.caption)
                    .foregroundStyle(.black.opacity(0.6))
                    .lineLimit(2)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(Color(hex: "#8a4f4c"))
        }
        .padding()
        .background(Color(hex: "#fde2e4"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    TopicCard(title: "Title", description: "Description", icon: "figure.child", iconColorHex: "#000000")
}
