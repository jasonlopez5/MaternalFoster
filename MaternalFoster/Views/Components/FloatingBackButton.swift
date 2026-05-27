//
//  FloatingBackButton.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/7/26.
//

import SwiftUI

struct FloatingBackButton: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Spacer()

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .padding(14)
                        .background(.ultraThinMaterial.opacity(0.7))
                        .clipShape(Circle())
                        .shadow(
                            color: .black.opacity(0.12),
                            radius: 6,
                            x: 0,
                            y: 3
                        )
                }

                Spacer()
            }
            .padding(.leading, 22)
            .padding(.bottom, 22)
        }
    }
}

#Preview {
    ZStack {
        Background()

        FloatingBackButton()
    }
}
