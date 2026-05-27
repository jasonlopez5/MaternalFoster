//
//  PageHeader.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/7/26.
//

import SwiftUI

struct PageHeader: View {
    let title: String
    let subtitle: String
    let icon: String
    let iconColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundStyle(iconColor)

                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.black.opacity(0.6))
        }
    }
}

#Preview {
    ZStack {
        Background()

        VStack(alignment: .leading, spacing: 24) {
            PageHeader(
                title: "Due Date Calculator",
                subtitle: "Estimate your due date based on your last menstrual period.",
                icon: "calendar",
                iconColor: Color(hex: "#8E7CC3")
            )

            PageHeader(
                title: "Warning Signs",
                subtitle: "Learn symptoms during pregnancy that may need medical attention.",
                icon: "exclamationmark.triangle",
                iconColor: .red
            )
        }
        .padding()
    }
}
