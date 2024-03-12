//
//  GratitudeDetailsViewModelTests.swift
//  NextTestTests
//
//  Created by Alin Zdurlan on 12.03.2024.
//

import Foundation
import XCTest
@testable import NextTest

class GratitudeDetailsViewModelTests: XCTestCase {
    private var viewModel: GratitudeDetailsViewModel!

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testInit() {
        let mockEntry = GratitudeEntry.mockedNoImageNoTags
        viewModel = GratitudeDetailsViewModel(gratitudeEntry: mockEntry, controller: MockedController(), navManager: NavigationStateManager())

        XCTAssertEqual(viewModel.gratitudeEntry, mockEntry)
    }

    func testEdit() {
        let mockEntry = GratitudeEntry.mockedNoImageNoTags
        let controller = MockedController()
        viewModel = GratitudeDetailsViewModel(gratitudeEntry: mockEntry, controller: controller, navManager: NavigationStateManager())

        XCTAssertEqual(viewModel.gratitudeEntry, mockEntry)
        XCTAssertFalse(controller.didEditEntry)
        viewModel.editEntry()

        XCTAssertFalse(viewModel.gratitudeEntry.summary == mockEntry.summary)
        XCTAssertEqual(viewModel.gratitudeEntry.summary, "Test entry edit")
        XCTAssertTrue(controller.didEditEntry)
    }
}

class MockedController: EntryController {
    var didFetchEntries = false
    var didEditEntry = false
    var didDeleteEntry = false

    func fetchEntries() {
        didFetchEntries = true
    }
    
    func editEntry(_ gratitudeEntry: GratitudeEntry) {
        didEditEntry = true
    }
    
    func deleteEntry(_ gratitudeEntry: GratitudeEntry) {
        didDeleteEntry = true
    }
}
