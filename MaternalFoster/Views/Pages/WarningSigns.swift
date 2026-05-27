//
//  WarningSigns.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/3/26.
//

import SwiftUI

struct WarningSigns: View {
    let topics = AppTopics.warningSigns
    
    @EnvironmentObject var auth: Authentication
    @State private var showSidebar = false
    @State private var cdcContent: CDCContent?
    @State private var isLoadingCDC = false
    @State private var cdcError: String?
    @EnvironmentObject var navigation: AppNavigation

    

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
                    VStack(alignment: .leading, spacing: 24) {
                        BreadcrumbBar(
                            previousPage: "Home",
                            currentPage: "Warning Signs",
                            onPreviousTap: {
                                navigation.goHome()
                            }
                        )
                        headerSection
                        emergencyCard
                        cdcSection
                        myHealthfinderSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 28)
                    .padding(.bottom, 64)
                }
            }
            FloatingBackButton()
            SidebarOverlay(showSidebar: $showSidebar)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await loadCDCContent()
        }
    }

    private var headerSection: some View {
        PageHeader(
            title: "Warning Signs",
            subtitle: "Learn symptoms during pregnancy that may need medical attention.",
            icon: "exclamationmark.triangle",
            iconColor: .red
        )
    }

    private var emergencyCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(.red)

                Text("Seek help right away")
                    .font(.headline)
                    .fontWeight(.bold)
            }

            Text("If you have severe bleeding, chest pain, trouble breathing, seizures, or thoughts of harming yourself, seek emergency help right away.")
                .font(.subheadline)
                .foregroundStyle(.black)
        }
        .padding()
        .background(Color(hex: "#FFE5E5"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.red.opacity(0.18), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
    }

    private var cdcSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("CDC Hear Her Guidance")
                .font(.title2)
                .fontWeight(.bold)

            Text("Urgent pregnancy-related warning signs from the CDC.")
                .font(.subheadline)
                .foregroundStyle(.black.opacity(0.6))

            if isLoadingCDC {
                LoadingAPIContentCard()
                    .padding(.top, 30)
            } else if let cdcError {
                Text(cdcError)
                    .font(.subheadline)
                    .foregroundStyle(.red)
                    .padding()
                    .background(Color(hex: "#f8aaa6"))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            } else if let cdcContent {
                VStack(alignment: .leading, spacing: 12) {
                    HTMLContentView(html: cdcContent.html)
                        .frame(height: 360)

                    Link(destination: cdcContent.sourceURL) {
                        HStack(spacing: 8) {
                            Image(systemName: "checkmark.seal.fill")
                            Text("Content provided by CDC Hear Her")
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(Color(hex: "#f06d6a"))
                    }

                    Text("CDC content does not imply endorsement of this app.")
                        .font(.caption)
                        .foregroundStyle(.black.opacity(0.7))
                }
                .padding()
                .background(Color(hex: "#fde2e4"))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
            }
        }
    }

    private var myHealthfinderSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Related Health Topics")
                .font(.title2)
                .fontWeight(.bold)

            VStack(spacing: 14) {
                ForEach(topics) { topic in
                    NavigationLink {
                        HealthTopicDetailView(
                            topic: topic,
                            previousPage: "Warning Signs"
                        )
                    } label: {
                        TopicCard(title: topic.title,
                                  description: topic.description,
                                  icon: topic.icon,
                                  iconColorHex: topic.iconColorHex)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private func loadCDCContent() async {
        guard cdcContent == nil else { return }

        isLoadingCDC = true
        cdcError = nil

        do {
            cdcContent = try await CDCService.shared.fetchHearHerWarningSigns()
        } catch {
            cdcError = "Unable to load CDC guidance right now."
        }

        isLoadingCDC = false
    }
}

#Preview {
    NavigationStack {
        WarningSigns()
            .environmentObject(AppNavigation())
            .environmentObject(Authentication())
    }
}
