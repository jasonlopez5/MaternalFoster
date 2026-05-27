//
//  SidebarOverlay.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/5/26.
//

import SwiftUI

struct SidebarOverlay: View {
    @Binding var showSidebar: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            Color.black.opacity(showSidebar ? 0.35 : 0)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.35)) {
                        showSidebar = false
                    }
                }
                .allowsHitTesting(showSidebar)

            Sidebar {
                withAnimation(.easeInOut(duration: 0.35)) {
                    showSidebar = false
                }
            }
            .offset(x: showSidebar ? 0 : -220)
        }
    }
}
#Preview {
    NavigationStack {
        let navigation: AppNavigation
        SidebarOverlay(showSidebar: Binding.constant(true))
            .environmentObject(AppNavigation())
            .environmentObject(Authentication())
    }
}
