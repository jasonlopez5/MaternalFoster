//
//  Sidebar.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/1/26.
//

import SwiftUI
import FirebaseAuth

struct Sidebar: View {
    @EnvironmentObject var auth: Authentication
    @EnvironmentObject var navigation: AppNavigation
    var onClose: () -> Void
    
    private var currentRoute: AppRoute {
        navigation.path.last ?? .home
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(alignment: .top) {
                if let url = auth.user?.photoURL {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 42, height: 42)
                    .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .font(.title)
                        .foregroundStyle(Color(hex: "#f8aaa6"))
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(auth.user?.displayName ?? "User")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(auth.user?.email ?? "")
                        .font(.caption)
                        .foregroundStyle(.black.opacity(0.6))
                }

                Spacer()

                Button {
                    onClose()
                } label: {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .foregroundStyle(.black)
                }
            }

            VStack(alignment: .leading, spacing: 18) {
                Button {
                    navigation.goHome()
                    onClose()
                } label: {
                    sidebarRow(
                        title: "Home",
                        icon: "house.fill",
                        iconColor: Color(hex: "#f8aaa6"),
                        isSelected: currentRoute == .home
                    )
                }
                .buttonStyle(.plain)

                ForEach(appMenuItems) { item in
                    Button {
                        navigation.goTo(item.route)
                        onClose()
                    } label: {
                        sidebarRow(
                            title: item.title,
                            icon: item.icon,
                            iconColor: item.iconColor,
                            isSelected: currentRoute == item.route
                        )
                    }
                    .buttonStyle(.plain)
                    .simultaneousGesture(TapGesture().onEnded {
                        onClose()
                    })
                }
                
            }

            Spacer()

            Button {
                auth.signOut()
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .frame(width: 26)

                    Text("Sign Out")
                        .fontWeight(.medium)
                }
                .foregroundStyle(.red)
                .padding(.bottom, 30)
            }
            
        }
        .padding(.horizontal, 24)
        .frame(width: 185)
        .padding(.top, 70)
        .frame(maxHeight: .infinity, alignment: .leading)
        .background(Color(hex: "#fde2e4"))
        .ignoresSafeArea()
    }
}

private func sidebarRow(title: String, icon: String, iconColor: Color, isSelected: Bool) -> some View {
    HStack(spacing: 14) {
        Image(systemName: icon)
            .foregroundStyle(iconColor)
            .frame(width: 1)

        Text(title)
            .font(.body)
            .fontWeight(.medium)
            .foregroundStyle(.black)
            .lineLimit(2)
            .fixedSize(horizontal: false, vertical: true)

        Spacer()
    }
    .padding(.vertical, 8)
    .padding(.horizontal, 10)
    .background(
        isSelected ? Color(hex: "#f8aaa6").opacity(0.45) : Color.clear
    )
    .clipShape(RoundedRectangle(cornerRadius: 12))
}



#Preview {
    let auth = Authentication()
    let navigation = AppNavigation()

    auth.user = nil

    navigation.path = [.healthNutrition]

    return ZStack(alignment: .leading) {
        Color.gray.opacity(0.2)
            .ignoresSafeArea()

        Sidebar {
            //
        }
        .environmentObject(auth)
        .environmentObject(navigation)
    }
}
