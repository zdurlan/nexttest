//
//  GratitudeEntryService.swift
//  NextTest
//
//  Created by Alin Zdurlan on 12.03.2024.
//

import Combine
import Foundation

protocol GratitudeEntryService {
    func fetchEntries() -> AnyPublisher<[GratitudeEntry], GratitudeEntryServiceError>
    func edit(entry: GratitudeEntry) -> AnyPublisher<GratitudeEntry, GratitudeEntryServiceError>
    func delete(entry: GratitudeEntry) -> AnyPublisher<String, GratitudeEntryServiceError>
}

enum GratitudeEntryServiceError: Error {
    case notFound
}

class NextGratitudeEntryService: GratitudeEntryService {
    func fetchEntries() -> AnyPublisher<[GratitudeEntry], GratitudeEntryServiceError> {
        // TODO: Aici as pune networkclientul si as face callurile propriu zise
        return Just([])
            .setFailureType(to: GratitudeEntryServiceError.self)
            .eraseToAnyPublisher()
    }

    func edit(entry: GratitudeEntry) -> AnyPublisher<GratitudeEntry, GratitudeEntryServiceError> {
        // TODO: Add real server connection
        return Just(.mockedNoImageNoTags)
            .setFailureType(to: GratitudeEntryServiceError.self)
            .eraseToAnyPublisher()
    }

    func delete(entry: GratitudeEntry) -> AnyPublisher<String, GratitudeEntryServiceError> {
        // TODO: Add real server connection
        return Just("")
            .setFailureType(to: GratitudeEntryServiceError.self)
            .eraseToAnyPublisher()
    }
}

class MockGratitudeEntryService: GratitudeEntryService {
    var mockedEntries = [GratitudeEntry.mockedNoImageNoTags, .mockedNoImageWithTags, .mockedWithImageAndTags, .mockedWithImageNoTags]

    func fetchEntries() -> AnyPublisher<[GratitudeEntry], GratitudeEntryServiceError> {
        return Future<[GratitudeEntry], GratitudeEntryServiceError> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                promise(.success(self.mockedEntries))
            }
        }
        .eraseToAnyPublisher()
    }

    func edit(entry: GratitudeEntry) -> AnyPublisher<GratitudeEntry, GratitudeEntryServiceError> {
        return Future<GratitudeEntry, GratitudeEntryServiceError> { promise in
            if let idx = self.mockedEntries.firstIndex(of: entry) {
                self.mockedEntries[idx] = entry
                promise(.success(entry))
            } else {
                promise(.failure(GratitudeEntryServiceError.notFound))
            }
        }
        .eraseToAnyPublisher()
    }

    func delete(entry: GratitudeEntry) -> AnyPublisher<String, GratitudeEntryServiceError> {
        return Future<String, GratitudeEntryServiceError> { promise in
            let targetEntry = self.mockedEntries.first(where: { $0 == entry })
            if let entryToBeDeleted = targetEntry {
                if let idx = self.mockedEntries.firstIndex(of: entryToBeDeleted) {
                    self.mockedEntries.remove(at: idx)
                    promise(.success("Note deleted successfully!"))
                }
            } else {
                promise(.failure(GratitudeEntryServiceError.notFound))
            }
        }
        .eraseToAnyPublisher()
    }
}
