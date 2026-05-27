//
//  FeatureGrid.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/2/26.
//

import SwiftUI

struct FeatureGrid: View {
    let isSignedIn: Bool

    let columns = [
        GridItem(.fixed(165), spacing: 14),
        GridItem(.fixed(165), spacing: 14)
    ]

    var body: some View {
        VStack(spacing: 14) {
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(appMenuItems.prefix(4)) { item in
                    featureItem(item)
                }
            }

            if let lastItem = appMenuItems.last {
                featureItem(lastItem)
            }
        }
        .padding(.horizontal, 20)
    }

    @ViewBuilder
    private func featureItem(_ item: MenuItem) -> some View {
        if isSignedIn {
            NavigationLink(value: item.route) {
                FeatureCard(
                    title: item.title,
                    icon: item.icon,
                    description: item.description,
                    iconColor: item.iconColor,
                    isSignedIn: true,
                )
            }
            .buttonStyle(.plain)
        } else {
            FeatureCard(
                title: item.title,
                icon: item.icon,
                description: item.description,
                iconColor: item.iconColor,
                isSignedIn: false,
            )
        }
    }
}

#Preview {
    FeatureGrid(isSignedIn: true)
}
