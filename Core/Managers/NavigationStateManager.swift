//
//  NavigationStateManager.swift
//  NextTest
//
//  Created by Alin Zdurlan on 11.03.2024.
//

import SwiftUI

enum CoreNavigationPath: Hashable {
    case details(gratitude: GratitudeEntry)
}

class NavigationStateManager: ObservableObject {
    @Published var routes: [CoreNavigationPath] = []

    func popToRoot() {
        routes = []
    }

    func pop() {
        if !routes.isEmpty {
            routes.removeLast()
        }
    }

    func goToDetails(gratitude: GratitudeEntry) {
        routes.append(.details(gratitude: gratitude))
    }
}
