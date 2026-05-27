//
//  WeekByWeekViewModel.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/4/26.
//

import Foundation
import FirebaseFirestore
internal import Combine

@MainActor
class WeekByWeekViewModel: ObservableObject {
    @Published var currentRange: PregnancyWeekRange?
    @Published var currentOrder = 1
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let db = Firestore.firestore()
    private let minOrder = 1
    private let maxOrder = 10

    var canGoBack: Bool {
        currentOrder > minOrder
    }

    var canGoForward: Bool {
        currentOrder < maxOrder
    }

    func loadCurrentRange() async {
        isLoading = true
        errorMessage = nil

        do {
            let snapshot = try await db.collection("pregnancyWeekRanges")
                .whereField("order", isEqualTo: currentOrder)
                .limit(to: 1)
                .getDocuments()

            guard let document = snapshot.documents.first else {
                currentRange = nil
                errorMessage = "No content found for this week range."
                isLoading = false
                return
            }
            
            print("RAW FIRESTORE DATA:", document.data())
            currentRange = try document.data(as: PregnancyWeekRange.self)
        } catch {
            currentRange = nil
            print("Firestore ERROR:", error)
            errorMessage = "Could not load week content:\(error.localizedDescription)."
        }

        isLoading = false
    }

    func goBack() async {
        guard canGoBack else { return }
        currentOrder -= 1
        await loadCurrentRange()
    }
    
    func goForward() async {
        guard canGoForward else { return }
        currentOrder += 1
        await loadCurrentRange()
    }
    
    // jumping to specific range on progress bar
    func jumpToOrder(_ order: Int) async {
        guard order >= minOrder && order <= maxOrder else { return }
        currentOrder = order
        await loadCurrentRange()
    }
}
