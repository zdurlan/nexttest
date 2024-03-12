//
//  GratitudeEntryViewModel.swift
//  NextTest
//
//  Created by Alin Zdurlan on 12.03.2024.
//

import Foundation

class GratitudeEntryViewModel: ObservableObject {
    @Published var entry: GratitudeEntry
    @Published var isExpanded: Bool

    init(entry: GratitudeEntry, isExpanded: Bool) {
        self.entry = entry
        self.isExpanded = isExpanded
    }
}
