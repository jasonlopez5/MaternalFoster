//
//  PregnancyWeekRange.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/4/26.
//

import Foundation
import FirebaseFirestore

struct PregnancyWeekRange: Identifiable, Codable {
    @DocumentID var documentId: String?

    let id: String
    let order: Int
    let range: String
    let trimester: String
    let title: String
    let summary: String
    let babyDevelopment: String
    let motherChanges: String
    let tips: [String]
    let sources: [WeekSource]
}

struct WeekSource: Codable, Identifiable {
    var id: String { url }

    let name: String
    let url: String
}
