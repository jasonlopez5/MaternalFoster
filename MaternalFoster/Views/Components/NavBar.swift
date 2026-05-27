//
//  NavBar.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/1/26.
//

import SwiftUI
import FirebaseAuth

struct NavBar: View {
    var isSignedIn: Bool
    var onMenuTap: () -> Void
    var onSignInTap: () -> Void
    var onSignOutTap: () -> Void
    let onHomeTap: () -> Void
    @EnvironmentObject var auth: Authentication

    var body: some View {
        HStack {
            if isSignedIn {
                Button {
                    onMenuTap()
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                        .foregroundStyle(.black)
                }
            } else {
                Spacer().frame(width: 28)
            }

            Spacer()
            
            Button {
                onHomeTap()
            } label: {
                Text("MaternalFoster")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
            }
            .buttonStyle(.plain)
            

            Spacer()

            if isSignedIn {
                Menu {
                    Button(role: .destructive) {
                        onSignOutTap()
                    } label: {
                        Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                } label: {
                    if let url = auth.user?.photoURL {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.black)
                    }
                }
            } else {
                Button {
                    onSignInTap()
                } label: {
                    Text("Sign In")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity)
        .background(.clear)
    }
}

#Preview {
    VStack {
        NavBar(
            isSignedIn: false,
            onMenuTap: {},
            onSignInTap: {},
            onSignOutTap: {},
            onHomeTap: {}
        )
        Spacer()
    }
}
