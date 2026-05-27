//
//  FeatureCard.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/2/26.
//

import SwiftUI

struct FeatureCard: View {
    let title: String
    let icon: String
    let description: String
    let iconColor: Color
    let isSignedIn: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: icon)
                        .foregroundColor(iconColor)
                        .frame(width: 22)

                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.black)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Text(description)
                    .font(.caption)
                    .foregroundStyle(.black.opacity(0.75))
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer()
            }
            .padding(14)
            .frame(width: 165, height: 125, alignment: .topLeading)
            .background(Color(hex: "#fde2e4"))
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.white.opacity(0.25))
            )
            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)

            if isSignedIn {
                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .foregroundStyle(Color(hex: "#8a4f4c"))
                    .frame(width: 26, height: 26)
                    .background(.clear)
                    .padding(8)
            }
        }
    }
}


#Preview {
    FeatureCard(
        title: "Week-by-Week Guide",
        icon: "list.bullet.rectangle",
        description: "Track your baby’s growth and changes each week.",
        iconColor: Color.red,
        isSignedIn: true,
    )
}
