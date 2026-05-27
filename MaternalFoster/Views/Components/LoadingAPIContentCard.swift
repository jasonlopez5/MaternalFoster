//
//  LoadingAPIContentCard.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/5/26.
//

import SwiftUI

struct LoadingAPIContentCard: View {
    @State private var isAnimating = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            loadingBar(width: 360, height: 44)
            loadingBar(width: 190, height: 18)

            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 12) {
                    loadingBar(width: 240, height: 16)
                    loadingBar(width: 330, height: 16)
                    loadingBar(width: 220, height: 16)

                    Spacer()

                    loadingBar(width: 180, height: 16)
                    loadingBar(width: 260, height: 12)
                }
                .frame(height: 520)
            }
            .padding()
            .background(Color(hex: "#fde2e4"))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
        }
        .opacity(isAnimating ? 0.55 : 1)
        .animation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true), value: isAnimating)
        .onAppear {
            isAnimating = true
        }
    }

    private func loadingBar(width: CGFloat, height: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.white.opacity(0.7))
            .frame(width: width, height: height)
    }
}

#Preview {
    LoadingAPIContentCard()
}
