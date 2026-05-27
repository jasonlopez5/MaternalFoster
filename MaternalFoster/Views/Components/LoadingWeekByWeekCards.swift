//
//  LoadingWeekByWeekCards.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/5/26.
//

import SwiftUI

import SwiftUI

struct LoadingWeekByWeekCards: View {
    @State private var isAnimating = false

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            weekCardSkeleton

            infoCardSkeleton(titleWidth: 170)
            infoCardSkeleton(titleWidth: 145)
        }
        .opacity(isAnimating ? 0.55 : 1)
        .animation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true), value: isAnimating)
        .onAppear {
            isAnimating = true
        }
    }

    private var weekCardSkeleton: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color(hex: "#8a4f4c"))
                    .frame(width: 38, height: 38)

                Spacer()

                VStack(spacing: 8) {
                    loadingBar(width: 120, height: 12)
                    loadingBar(width: 150, height: 24)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundStyle(Color(hex: "#8a4f4c"))
                    .frame(width: 38, height: 38)
            }

            loadingBar(width: 210, height: 22)
            loadingBar(width: 290, height: 14)
            loadingBar(width: 250, height: 14)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "#fde2e4"))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
    }

    private func infoCardSkeleton(titleWidth: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Circle()
                    .fill(Color(hex: "#f8aaa6").opacity(0.7))
                    .frame(width: 18, height: 18)

                loadingBar(width: titleWidth, height: 18)
            }

            loadingBar(width: 295, height: 14)
            loadingBar(width: 270, height: 14)
            loadingBar(width: 230, height: 14)
            loadingBar(width: 260, height: 14)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "#fde2e4"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private func loadingBar(width: CGFloat, height: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.white.opacity(0.7))
            .frame(width: width, height: height)
    }
}

#Preview {
    LoadingWeekByWeekCards()
}
