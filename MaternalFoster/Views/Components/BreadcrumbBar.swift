//
//  BreadcrumbBar.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/7/26.
//

import SwiftUI

struct BreadcrumbBar: View {
    let previousPage: String
    let currentPage: String
    let onPreviousTap: (() -> Void)?

    var body: some View {
        HStack(spacing: 6) {
            if let onPreviousTap {
                Button {
                    onPreviousTap()
                } label: {
                    Text(previousPage)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.black.opacity(0.65))
                }
            } else {
                Text(previousPage)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.black.opacity(0.65))
            }

            Image(systemName: "chevron.right")
                .font(.caption2)
                .foregroundStyle(.black.opacity(0.45))

            Text(currentPage)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    ZStack(alignment: .leading) {
        Background()

        VStack(spacing: 0) {
            NavBar(
                isSignedIn: true,
                onMenuTap: {},
                onSignInTap: {},
                onSignOutTap: {},
                onHomeTap: {}
            )

            VStack(alignment: .leading, spacing: 24) {
                BreadcrumbBar(
                    previousPage: "Home",
                    currentPage: "Health & Nutrition",
                    onPreviousTap: {}
                )

                PageHeader(
                    title: "Health & Nutrition",
                    subtitle: "Learn what to eat and how to stay healthy.",
                    icon: "heart.text.square",
                    iconColor: Color(hex: "#57A773")
                )
            }
            .padding(.horizontal, 22)
            .padding(.top, 18)
            Spacer()
        }
        .environmentObject(Authentication())
        .environmentObject(AppNavigation())
    }
}
