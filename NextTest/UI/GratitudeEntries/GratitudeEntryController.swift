//
//  GratitudeEntryController.swift
//  NextTest
//
//  Created by Alin Zdurlan on 12.03.2024.
//

import Combine
import Foundation

protocol EntryController {
    func fetchEntries()
    func editEntry(_ gratitudeEntry: GratitudeEntry)
    func deleteEntry(_ gratitudeEntry: GratitudeEntry)
}

class GratitudeEntryController: ObservableObject, EntryController {
    @Published private(set) var gratitudeEntries: [GratitudeEntry] = []

    let entryService: GratitudeEntryService
    private var cancellables = Set<AnyCancellable>()

    init(entryService: GratitudeEntryService) {
        self.entryService = entryService
    }

    func fetchEntries() {
        entryService.fetchEntries()
            .sink { _ in
                // handle errors
            } receiveValue: { [weak self] data in
                guard let self else { return }
                gratitudeEntries = data // puteam si fara published dar prefer sa folosesc cat de mult pot swiftui
                // sincer era mult mai clean fara combine, cu async await
            }
            .store(in: &cancellables)
    }

    func editEntry(_ gratitudeEntry: GratitudeEntry) {
        entryService.edit(entry: gratitudeEntry)
            .sink { _ in
                // handle errors
            } receiveValue: { [weak self] entry in
                guard let self = self else { return }
                if let idx = self.gratitudeEntries.firstIndex(of: entry) {
                    gratitudeEntries[idx] = gratitudeEntry
                }
            }
            .store(in: &cancellables)
    }

    func deleteEntry(_ gratitudeEntry: GratitudeEntry) {
       // TODO: Add delete
    }
}
