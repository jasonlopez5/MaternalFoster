//
//  AppTopics.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/3/26.
//

import SwiftUI

enum AppTopics {
    static let healthNutrition: [HealthTopic] = [
        HealthTopic(
            id: "30583",
            title: "Eat Healthy During Pregnancy",
            description: "Quick tips for healthy eating while pregnant.",
            icon: "fork.knife",
            iconColorHex: "#57A773"
        ),
        HealthTopic(
            id: "327",
            title: "Folic Acid",
            description: "Learn why folic acid matters before and during pregnancy.",
            icon: "leaf.fill",
            iconColorHex: "#6AB187"
        ),
        HealthTopic(
            id: "30530",
            title: "Calcium",
            description: "Guidance for getting enough calcium.",
            icon: "drop.fill",
            iconColorHex: "#5DADEC"
        ),
        HealthTopic(
            id: "30617",
            title: "Stay Active During Pregnancy",
            description: "Quick tips for safe physical activity.",
            icon: "figure.walk",
            iconColorHex: "#F4A261"
        ),
        HealthTopic(
            id: "30548",
            title: "Healthy Pregnancy Basics",
            description: "General guidance for a healthy pregnancy.",
            icon: "heart.text.square",
            iconColorHex: "#E76F51"
        )
    ]

    static let warningSigns: [HealthTopic] = [
        HealthTopic(
            id: "30600",
            title: "Preventing Preeclampsia",
            description: "Learn questions to ask your doctor about preeclampsia.",
            icon: "heart.fill",
            iconColorHex: "#E76F51"
        ),
        HealthTopic(
            id: "30545",
            title: "Preventing Infections",
            description: "Find ways to prevent infections during pregnancy.",
            icon: "shield.fill",
            iconColorHex: "#F4A261"
        ),
        HealthTopic(
            id: "30546",
            title: "Use Medicines Safely",
            description: "Learn how to talk with your doctor about medicines.",
            icon: "pills.fill",
            iconColorHex: "#8E7CC3"
        ),
        HealthTopic(
            id: "30548",
            title: "Healthy Pregnancy Basics",
            description: "Review signs, visits, tests, and pregnancy care basics.",
            icon: "stethoscope",
            iconColorHex: "#5DADEC"
        )
    ]
    
    static let postBirthMotherHealthFinder: [HealthTopic] = [
        HealthTopic(
            id: "30550",
            title: "Breastfeed Your Baby",
            description: "Learn about breastfeeding.",
            icon: "figure.and.child.holdinghands",
            iconColorHex: "#8e7CC3"
        ),
        HealthTopic(
            id: "30582",
            title: "Eat Healthy While Breastfeeding",
            description: "Nutrition guidance for mothers who are breastfeeding.",
            icon: "fork.knife",
            iconColorHex: "#57A773"
        ),
    ]
    
    static let postBirthBabyHealthfinder: [HealthTopic] = [
        HealthTopic(
                id: "510",
                title: "Make the Most of Your Baby’s Visit to the Doctor",
                description: "Learn how to prepare for your baby’s doctor visits from ages 0 to 11 months.",
                icon: "stethoscope",
                iconColorHex: "#7B61FF"
            ),
            HealthTopic(
                id: "512",
                title: "Make the Most of Your Child’s Visit to the Doctor",
                description: "Get tips for making the most of doctor visits for children ages 1 to 4 years.",
                icon: "cross.case",
                iconColorHex: "#4CAF50"
            )
    ]
    
    static let postBirthCDC: [CDCResourceTopic] = [
        CDCResourceTopic(
            id: "398798",
            title: "Choosing an Infant Formula",
            description: "Learn how to choose the right formula for your baby.",
            icon: "drop.fill",
            iconColorHex: "#5DADEC"
        ),
        CDCResourceTopic(
            id: "398793",
            title: "When, What, and How to Introduce Solid Foods.",
            description: "Knowing when to introduce solid foods to your baby.",
            icon: "fork.knife",
            iconColorHex: "#57A773"
        ),
        CDCResourceTopic(
            id: "398877",
            title: "About Feeding From a Bottle",
            description: "Learn how to bottle feed your baby.",
            icon: "figure.child",
            iconColorHex: "#8e7CC3"
        )
    ]
}

