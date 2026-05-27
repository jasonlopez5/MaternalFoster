//
//  ContentView.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/1/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var auth: Authentication
    @StateObject private var navigation = AppNavigation()

    var body: some View {
        NavigationStack(path: $navigation.path) {
            Home()
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .home:
                        Home()
                    case .dueDate:
                        DueDate()
                    case .weekByWeek:
                        WeekByWeek()
                    case .healthNutrition:
                        HealthNutrition()
                    case .warningSigns:
                        WarningSigns()
                    case .postBirthCare:
                        PostBirth()
                    }
                }
        }
        .environmentObject(navigation)
        .onChange(of: auth.user) { _, newUser in
            if newUser == nil {
                navigation.goHome()
            }
        }
    }
}
#Preview {
    ContentView()
        .environmentObject(Authentication())
}
