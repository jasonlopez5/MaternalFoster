//
//  MenuItem.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/2/26.
//

import SwiftUI

struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let description: String
    let iconColor: Color
    let route: AppRoute
}

enum AppRoute: Hashable {
    case home
    case dueDate
    case weekByWeek
    case healthNutrition
    case warningSigns
    case postBirthCare
}

let appMenuItems: [MenuItem] = [
    MenuItem(
        title: "Due Date Calculator",
        icon: "calendar",
        description: "Estimate your due date and plan ahead.",
        iconColor: Color(hex: "#8E7CC3"),
        route: .dueDate
    ),
    MenuItem(
        title: "Week-by-Week",
        icon: "list.bullet.rectangle",
        description: "Track your baby’s growth and changes each week.",
        iconColor: Color(hex: "#5DADEC"),
        route: .weekByWeek
    ),
    MenuItem(
        title: "Health & Nutrition",
        icon: "heart.text.square",
        description: "Learn what to eat and how to stay healthy.",
        iconColor: Color(hex: "#57A773"),
        route: .healthNutrition
    ),
    MenuItem(
        title: "Warning Signs",
        icon: "exclamationmark.triangle",
        description: "Know when to seek medical attention.",
        iconColor: Color.red,
        route: .warningSigns
    ),
    MenuItem(
        title: "Post-Birth Care",
        icon: "figure.and.child.holdinghands",
        description: "Prepare for recovery and newborn care.",
        iconColor: Color(hex: "#F4A261"),
        route: .postBirthCare
    )
]

#Preview {
    NavigationStack {
        FeatureGrid(isSignedIn: true)
    }
}
