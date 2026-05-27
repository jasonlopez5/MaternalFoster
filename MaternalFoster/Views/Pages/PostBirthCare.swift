//
//  PostBirthCare.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/4/26.
//

import SwiftUI

struct PostBirth: View {
    let motherTopics = AppTopics.postBirthMotherHealthFinder
    let babyHealthFinderTopics = AppTopics.postBirthBabyHealthfinder
    let babyCDCTopics = AppTopics.postBirthCDC
    @EnvironmentObject var auth: Authentication
    @State private var showSidebar = false
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
                            currentPage: "Post-Birth Care",
                            onPreviousTap: {
                                navigation.goHome()
                            }
                        )
                        headerSection
                        motherRecoverySection
                        babyCareSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 28)
                    .padding(.bottom, 65)
                }
            }
            FloatingBackButton()
            SidebarOverlay(showSidebar: $showSidebar)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)    }
    
    // title and description of page 
    private var headerSection: some View {
        PageHeader(
            title: "Post-Birth Care",
            subtitle: "Guidance for recovery, newborn care, and life after birth.",
            icon: "figure.and.child.holdinghands",
            iconColor: Color(hex: "#F4A261")
        )

    }
    
    // section for mother
    private var motherRecoverySection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Mother’s Recovery")
                .font(.title2)
                .fontWeight(.bold)

            VStack(spacing: 14) {
                ForEach(motherTopics) { topic in
                    NavigationLink {
                        HealthTopicDetailView(
                            topic: topic,
                            previousPage: "Post-Birth Care"
                        )
                    } label: {
                        TopicCard(
                            title: topic.title,
                            description: topic.description,
                            icon: topic.icon,
                            iconColorHex: topic.iconColorHex
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
    
    // section for baby
    private var babyCareSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Baby Care")
                .font(.title2)
                .fontWeight(.bold)

            VStack(spacing: 14) {
                ForEach(babyHealthFinderTopics) { topic in NavigationLink {
                    HealthTopicDetailView(
                        topic: topic,
                        previousPage: "Post-Birth Care"
                    )
                } label: {
                    TopicCard(
                        title: topic.title, description: topic.description, icon: topic.icon, iconColorHex: topic.iconColorHex
                    )
                }
                .buttonStyle(.plain)
                }
                
                ForEach(babyCDCTopics) { topic in
                    NavigationLink {
                        CDCResourceDetailView(
                            topic: topic,
                            previousPage: "Post-Birth Care"
                        )
                    } label: {
                        TopicCard(
                            title: topic.title,
                            description: topic.description,
                            icon: topic.icon,
                            iconColorHex: topic.iconColorHex
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PostBirth()
            .environmentObject(AppNavigation())
            .environmentObject(Authentication())
    }
}
