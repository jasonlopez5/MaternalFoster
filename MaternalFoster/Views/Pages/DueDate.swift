//
//  DueDate.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/2/26.
//

import SwiftUI
import ConfettiSwiftUI

struct DueDate: View {
    @State private var lmpDate = Date()
    @State private var showResult = false
    @State private var confettiCounter = 0
    @EnvironmentObject var auth: Authentication
    @State private var showSidebar = false
    @EnvironmentObject var navigation: AppNavigation

    private let totalPregnancyDays = 280

    var dueDate: Date {
        Calendar.current.date(byAdding: .day, value: totalPregnancyDays, to: lmpDate) ?? lmpDate
    }
    
    var earliestValidLMPDate: Date {
        Calendar.current.date(byAdding: .day, value: -280, to: Date()) ?? Date()
    }
    
    var daysPregnant: Int {
        max(0, Calendar.current.dateComponents([.day], from: lmpDate, to: Date()).day ?? 0)
    }

    var weeksPregnant: Int {
        daysPregnant / 7
    }

    var extraDays: Int {
        daysPregnant % 7
    }

    var weeksRemaining: Int {
        max(0, 40 - weeksPregnant)
    }

    var trimester: String {
        if weeksPregnant < 13 {
            return "First Trimester"
        } else if weeksPregnant < 28 {
            return "Second Trimester"
        } else {
            return "Third Trimester"
        }
    }

    var progress: Double {
        min(Double(daysPregnant) / Double(totalPregnancyDays), 1.0)
    }

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
                            currentPage: "Due Date Calculator",
                            onPreviousTap: {
                                navigation.goHome()
                            }
                        )
                        
                        headerSection
                        inputSection
                        actionButtons
                        
                        if showResult {
                            resultCard
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 28)
                    .padding(.bottom, 64)
                }
            }
            .confettiCannon(
                trigger: $confettiCounter,
                num: 100,
                colors: [Color.blue, Color.pink, Color.white],
                rainHeight: 700,
                radius: 450
            )
            FloatingBackButton()
            SidebarOverlay(showSidebar: $showSidebar)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var headerSection: some View {
        PageHeader(
            title: "Due Date Calculator",
            subtitle: "Estimate your due date based on your last menstrual period.",
            icon: "calendar",
            iconColor: Color(hex: "#8E7CC3")
        )
    }

    private var inputSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("First day of last menstrual period")
                .font(.headline)

            DatePicker(
                "LMP Date",
                selection: $lmpDate,
                in: earliestValidLMPDate...Date(),
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
        }
        .padding()
        .background(Color(hex: "#fde2e4"))
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }

    private var actionButtons: some View {
        HStack(spacing: 12) {
            Button {
                withAnimation(.easeInOut) {
                    showResult = true
                }
                
                    confettiCounter += 1
                
            } label: {
                Text("Calculate")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .background(Color(hex: "#f8aaa6"))
            .foregroundStyle(.white)
            .clipShape(Capsule())

            Button {
                withAnimation(.easeInOut) {
                    lmpDate = Date()
                    showResult = false
                }
            } label: {
                Text("Reset")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .background(Color(hex: "#fde2e4"))
            .foregroundStyle(.black)
            .clipShape(Capsule())
        }
    }

    private var resultCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Congratulations!")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Your due date is \(dueDate.formatted(date: .long, time: .omitted)).")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(hex: "#f06d6a"))

                Text("You are \(weeksPregnant) weeks and \(extraDays) days pregnant.")
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.6))
            }

            ProgressView(value: progress)
                .tint(Color(hex: "#f8aaa6"))

            HStack {
                resultInfo(title: "Week", value: "\(min(weeksPregnant, 40)) of 40")
                resultInfo(title: "Trimester", value: trimester)
                resultInfo(title: "Remaining", value: "\(weeksRemaining) weeks")
            }
        }
        .padding()
        .background(Color(hex: "#fde2e4"))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.35))
        )
        
    }

    private func resultInfo(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.black.opacity(0.6))

            Text(value)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationStack {
        DueDate()
            .environmentObject(Authentication())
            .environmentObject(AppNavigation())
    }
}
