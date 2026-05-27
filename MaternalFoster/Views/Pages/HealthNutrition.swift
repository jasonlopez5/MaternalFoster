//
//  HealthNutrition.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/3/26.
//

import SwiftUI

struct HealthNutrition: View {
    let topics = AppTopics.healthNutrition
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
                    VStack(alignment: .leading, spacing: 22) {
                        BreadcrumbBar(
                            previousPage: "Home",
                            currentPage: "Health & Nutrition",
                            onPreviousTap: {
                                navigation.goHome()
                            }
                        )
                        
                        headerSection
                        
                        VStack(spacing: 14) {
                            ForEach(topics) { topic in
                                NavigationLink {
                                    HealthTopicDetailView(
                                        topic: topic,
                                        previousPage: "Health & Nutrition"
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
    }

    private var headerSection: some View {
        PageHeader(
            title: "Health & Nutrition",
            subtitle: "Trusted guidance for staying healthy during pregnancy.",
            icon: "heart.text.square",
            iconColor: Color(hex: "#57A773")
        )
    }
}

struct HealthTopicDetailView: View {
    let topic: HealthTopic
    let previousPage: String
    
    @State private var detail: MyHealthTopicDetail?
    @State private var isLoading = false
    @State private var errorMessage: String?
    @EnvironmentObject var auth: Authentication
    @State private var showSidebar = false
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
                        } else if let detail {
                            detailContent(detail)
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
            await loadTopic()
        }
    }

    private func detailContent(_ detail: MyHealthTopicDetail) -> some View {
        VStack(alignment: .leading, spacing: 18) {
            Text(detail.title)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Last Updated: \(formattedLastUpdated(detail.lastUpdated))")
                .font(.caption)
                .foregroundStyle(.black.opacity(0.6))

            VStack(alignment: .leading, spacing: 18) {
                ForEach(detail.sections) { section in
                    VStack(alignment: .leading, spacing: 10) {
                        if !section.title.isEmpty {
                            Text(section.title)
                                .font(.headline)
                                .fontWeight(.bold)
                        }

                        HTMLContentView(html: section.content)
                            .frame(height: 500)
                    }
                    .padding()
                    .background(Color(hex: "#fde2e4"))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 3)
                }
            }

            sourceSection(detail)
        }
    }

    private func sourceSection(_ detail: MyHealthTopicDetail) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Source")
                .font(.headline)

            Link(destination: detail.sourceURL) {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.seal.fill")
                    Text("Content provided by MyHealthfinder")
                        .fontWeight(.semibold)
                }
                .foregroundStyle(Color(hex: "#f06d6a"))
            }
        }
        .padding()
        .background(Color(hex: "#fde2e4"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private func loadTopic() async {
        isLoading = true
        errorMessage = nil

        do {
            detail = try await MyHealthfinderService.shared.fetchTopic(topicId: topic.id)
        } catch {
            errorMessage = "Unable to load this topic right now: \(error.localizedDescription)"
        }

        isLoading = false
    }

    private func formattedLastUpdated(_ timestamp: String) -> String {
        guard let seconds = TimeInterval(timestamp) else {
            return timestamp
        }

        let date = Date(timeIntervalSince1970: seconds)
        return date.formatted(date: .long, time: .omitted)
    }
}

#Preview {
    NavigationStack {
        HealthNutrition()
            .environmentObject(AppNavigation())
            .environmentObject(Authentication())
    }
}
