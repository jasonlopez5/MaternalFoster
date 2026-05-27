//
//  WeekByWeek.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/4/26.
//

import SwiftUI

struct WeekByWeek: View {
    @StateObject private var viewModel = WeekByWeekViewModel()
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
                            currentPage: "Week-By-Week",
                            onPreviousTap: {
                                navigation.goHome()
                            }
                        )
                        
                        headerSection

                        if viewModel.isLoading {
                            LoadingWeekByWeekCards()
                        } else if let range = viewModel.currentRange {
                            rangeCard(range)
                            
                            progressIndicator

                            detailSections(range)
                        } else if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .padding()
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
        .animation(.easeInOut(duration: 0.35), value: showSidebar)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await viewModel.loadCurrentRange()
        }
    }

    private var headerSection: some View {
        PageHeader(
            title: "Week-by-Week",
            subtitle: "Follow your baby’s development and your body’s changes throughout pregnancy.",
            icon: "list.bullet.rectangle",
            iconColor: Color(hex: "#5DADEC")
        )
    }

    private func rangeCard(_ range: PregnancyWeekRange) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center) {
                Button {
                    Task {
                        await viewModel.goBack()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundStyle(Color(hex: "#8a4f4c"))
                        .frame(width: 38, height: 38)
                        .background(.clear)
                }
                .disabled(!viewModel.canGoBack)
                .opacity(viewModel.canGoBack ? 1 : 0.35)

                Spacer()

                VStack(spacing: 4) {
                    Text(range.trimester)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black.opacity(0.55))

                    Text(range.range)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                }

                Spacer()

                Button {
                    Task {
                        await viewModel.goForward()
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.headline)
                        .foregroundStyle(Color(hex: "#8a4f4c"))
                        .frame(width: 38, height: 38)
                        .background(.clear)
                }
                .disabled(!viewModel.canGoForward)
                .opacity(viewModel.canGoForward ? 1 : 0.35)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(range.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)

                Text(range.summary)
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.65))
                    .lineSpacing(3)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "#fde2e4"))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
    }

    // progress bar for cards
    private var progressIndicator: some View {
        HStack(spacing: 6) {
            ForEach(1...10, id: \.self) { index in
                Button {
                    Task {
                        await viewModel.jumpToOrder(index)
                    }
                } label: {
                    Capsule()
                        .fill(index == viewModel.currentOrder ? Color(hex: "#f8aaa6") : Color.black.opacity(0.12))
                        .frame(width: index == viewModel.currentOrder ? 22 : 8, height: 6)
                        .animation(.easeInOut(duration: 0.25), value: viewModel.currentOrder)
                }
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func detailSections(_ range: PregnancyWeekRange) -> some View {
        VStack(alignment: .leading, spacing: 18) {
            infoSection(
                title: "Baby Development",
                icon: "figure.child",
                iconColor: Color(hex: "#8E7CC3"),
                content: range.babyDevelopment
            )

            infoSection(
                title: "Mother’s Body",
                icon: "heart.fill",
                iconColor: Color(hex: "#E76F51"),
                content: range.motherChanges
            )

            tipsSection(range.tips)

            sourcesSection(range.sources)
        }
    }
    
    private func infoSection(title: String, icon: String, iconColor: Color, content: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Label {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.black)
            } icon: {
                Image(systemName: icon)
                    .foregroundStyle(iconColor)
            }

            Text(content)
                .font(.subheadline)
                .foregroundStyle(.black.opacity(0.7))
                .lineSpacing(4)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "#fde2e4"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    // helpful tips card
    private func tipsSection(_ tips: [String]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Label{
                Text("Helpful Tips")
                    .font(.headline)
                    .foregroundStyle(.black)
            } icon: {
                Image(systemName: "lightbulb.fill")
                    .foregroundStyle(Color(hex: "#8a4f4c"))
            }
            
            ForEach(tips, id: \.self) { tip in
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.caption)
                        .padding(.top, 3)
                        .foregroundStyle(Color(hex: "#f8aaa6"))

                    Text(tip)
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.7))
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "#fde2e4"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private func sourcesSection(_ sources: [WeekSource]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Sources")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.black.opacity(0.6))

            ForEach(sources) { source in
                if let url = URL(string: source.url) {
                    Link(source.name, destination: url)
                        .font(.caption)
                }
            }
        }
        .padding(.top, 4)
    }
}

#Preview {
    NavigationStack {
        WeekByWeek()
            .environmentObject(AppNavigation())
            .environmentObject(Authentication())
    }
}
