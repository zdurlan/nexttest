//
//  TimelineViewModel.swift
//  NextTest
//
//  Created by Alin Zdurlan on 11.03.2024.
//

import Combine
import Foundation

class TimelineViewModel: ObservableObject {
    private let controller: GratitudeEntryController
    private var cancellables = Set<AnyCancellable>()

    @Published var recentEntries: [GratitudeEntry] = []
    @Published var olderEntries: [GratitudeEntry] = []
    @Published var isLoading = false // in mod normal as face state special cu enum cu loading, displayed etc

    var totalEntries: [GratitudeEntry]

    // TODO: Add data from mock/real object with combine
    init(controller: GratitudeEntryController) {
        self.controller = controller
        self.totalEntries = controller.gratitudeEntries

        controller.$gratitudeEntries.sink { [weak self] in
            self?.totalEntries = $0
            self?.getRecentEntries()
            self?.getOlderEntries()
            self?.isLoading = false
        }
        .store(in: &cancellables)
    }

    func getEntries() {
        if totalEntries.isEmpty {
            isLoading = true
            controller.fetchEntries()
        }
    }

    func getRecentEntries() {
        recentEntries = Array(totalEntries.sorted(by: { $0.date < $1.date }).prefix(2))
    }

    func getOlderEntries() {
        olderEntries = Array(totalEntries.sorted(by: { $0.date > $1.date }).prefix(2))
    }
}
