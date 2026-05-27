//
//  CDCResourceDetailView.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/4/26.
//

import SwiftUI

struct CDCResourceDetailView: View {
    let topic: CDCResourceTopic
    let previousPage: String
    
    @State private var content: CDCContent?
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var showSidebar = false
    @EnvironmentObject var auth: Authentication
    @EnvironmentObject var navigation: AppNavigation
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .leading) {
            Background()
            
            VStack(spacing: 0) {
                NavBar(
                    isSignedIn: true,
                    onMenuTap: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            showSidebar = true
                        }
                    },
                    onSignInTap: {},
                    onSignOutTap: {
                        auth.signOut()
                    },
                    onHomeTap: {
                        navigation.goHome()
                    }
                )
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        BreadcrumbBar(
                            previousPage: previousPage,
                            currentPage: topic.title,
                            onPreviousTap: {
                                dismiss()
                            }
                        )
                        
                        if isLoading {
                            LoadingAPIContentCard()
                        } else if let errorMessage {
                            Text(errorMessage)
                                .foregroundStyle(.red)
                                .padding()
                        } else if let content {
                            detailContent(content)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 28)
                    .padding(.bottom, 30)
                }
            }
            FloatingBackButton()
            SidebarOverlay(showSidebar: $showSidebar)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await loadContent()
        }
    }

    private func detailContent(_ content: CDCContent) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(content.title)
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(alignment: .leading, spacing: 12) {
                HTMLContentView(html: content.html)
                    .frame(height: 420)

                Link(destination: content.sourceURL) {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.seal.fill")
                        Text("Content provided by CDC")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(Color(hex: "#f06d6a"))
                }

                Text("CDC content does not imply endorsement of this app.")
                    .font(.caption)
                    .foregroundStyle(.black.opacity(0.6))
            }
            .padding()
            .background(Color(hex: "#fde2e4"))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
        }
    }

    private func loadContent() async {
        guard content == nil else { return }

        isLoading = true
        errorMessage = nil

        do {
            content = try await CDCService.shared.fetchCDCResource(
                mediaId: topic.id,
                fallbackTitle: topic.title
            )
        } catch {
            errorMessage = "Unable to load CDC guidance right now."
        }

        isLoading = false
    }
}

#Preview {
    NavigationStack {
        CDCResourceDetailView(
            topic: CDCResourceTopic(
                id: "398798",
                title: "Choosing an Infant Formula",
                description: "Learn about choosing infant formula safely.",
                icon: "drop.fill",
                iconColorHex: "#f8aaa6"
            ),
            previousPage: "Warning Signs"
        )
        .environmentObject(Authentication())
        .environmentObject(AppNavigation())
    }
}
