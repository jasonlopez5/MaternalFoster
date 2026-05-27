//
//  AppNavigation.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/5/26.
//

import SwiftUI
internal import Combine

class AppNavigation: ObservableObject {
    @Published var path: [AppRoute] = []

    func goHome() {
        path.removeAll()
    }
    
    func goTo(_ route: AppRoute) {
        if route == .home {
            path.removeAll()
        } else {
            path = [route]
        }
    }
}

