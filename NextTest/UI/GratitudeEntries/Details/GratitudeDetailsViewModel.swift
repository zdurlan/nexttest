//
//  GratitudeDetailsViewModel.swift
//  NextTest
//
//  Created by Alin Zdurlan on 11.03.2024.
//

import Foundation
import SwiftUI

class GratitudeDetailsViewModel: ObservableObject {
    private let controller: EntryController
    private let navManager: NavigationStateManager

    @Published var gratitudeEntry: GratitudeEntry

    init(gratitudeEntry: GratitudeEntry, controller: EntryController, navManager: NavigationStateManager) {
        self.gratitudeEntry = gratitudeEntry
        self.controller = controller
        self.navManager = navManager
    }

    func editEntry() {
        gratitudeEntry.summary = "Test entry edit"
        controller.editEntry(gratitudeEntry)
        navManager.pop()
    }

    func deleteEntry() {
        controller.deleteEntry(gratitudeEntry)
        navManager.pop()
    }
}
