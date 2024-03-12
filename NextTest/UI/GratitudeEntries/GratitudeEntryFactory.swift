//
//  GratitudeEntryFactory.swift
//  NextTest
//
//  Created by Alin Zdurlan on 12.03.2024.
//

import Foundation

class GratitudeEntryFactory: ObservableObject {
    // Change with real server when needed
    private let gratitudeEntryController = GratitudeEntryController(entryService: MockGratitudeEntryService())

    func makeTimelineViewModel() -> TimelineViewModel {
        TimelineViewModel(controller: gratitudeEntryController)
    }

    func makeEntryViewModel(entry: GratitudeEntry, isExpanded: Bool) -> GratitudeEntryViewModel {
        GratitudeEntryViewModel(entry: entry, isExpanded: isExpanded)
    }

    func makeDetailsViewModel(gratitudeEntry: GratitudeEntry, navManager: NavigationStateManager) -> GratitudeDetailsViewModel {
        GratitudeDetailsViewModel(gratitudeEntry: gratitudeEntry, controller: gratitudeEntryController, navManager: navManager)
    }
}
