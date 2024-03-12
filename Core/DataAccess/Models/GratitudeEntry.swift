//
//  GratitudeEntry.swift
//  NextTest
//
//  Created by Alin Zdurlan on 11.03.2024.
//

import Foundation
import UIKit.UIImage
import SwiftUI

struct GratitudeEntry: Codable, Hashable {
    let id: Int
    let date: Date
    var summary: String
    var images: [Data]?
    var tags: [Tag]?

    static func == (lhs: GratitudeEntry, rhs: GratitudeEntry) -> Bool {
        lhs.id == rhs.id
    }

    var dateAsString: String {
        DateUtil.format(date: self.date, with: .fulldate)
    }

    var title: String {
        self.summary
    }

    var hasImage: Bool {
        !(self.images?.isEmpty ?? true)
    }

    var mainImage: Image? {
        guard let imageData = self.images?.first,
              let image = UIImage(data: imageData) else {
            return nil
        }

        return Image(uiImage: image)
    }

    var imageArray: [HashableImage] {
        guard let images else { return [] }
        var imageArray: [HashableImage] = []
        for imageData in images {
            guard let image = UIImage(data: imageData) else {
                return []
            }

            imageArray.append(.init(image: Image(uiImage: image), imageData: imageData))
        }
        return imageArray
    }

    var hasTags: Bool {
        !(self.tags?.isEmpty ?? true)
    }
}

struct HashableImage: Hashable {
    let image: Image
    let imageData: Data

    func hash(into hasher: inout Hasher) {
        hasher.combine(imageData)
    }
}

extension GratitudeEntry {
    static var mockedNoImageNoTags: GratitudeEntry {
        .init(id: -1, date: Date(timeIntervalSinceNow: -5 * 60), summary: "This is a mocked gratitude entry with no image and no tags", images: nil, tags: nil)
    }

    static var mockedNoImageWithTags: GratitudeEntry {
        .init(id: -2, date: Date(timeIntervalSinceNow: -5 * 60), summary: "This is a mocked gratitude entry with no image but with tags", images: nil, tags: [.mocked])
    }

    static var mockedWithImageNoTags: GratitudeEntry {
        guard let img = UIImage(named: "gratitude"),
              let data = img.jpegData(compressionQuality: 1) else {
            assertionFailure("No image provided in the assets")
            return .mockedNoImageNoTags
        }

        return .init(id: -3, date: Date(timeIntervalSinceNow: -5 * 60), summary: "This is a mocked gratitude entry with an image but without tags", images: [data], tags: nil)
    }

    static var mockedWithImageAndTags: GratitudeEntry {
        guard let gratitudeImg = UIImage(named: "gratitude"),
              let gratitudeData = gratitudeImg.jpegData(compressionQuality: 1) else {
            assertionFailure("No image provided in the assets")
            return .mockedNoImageNoTags
        }

        guard let haroldImage = UIImage(named: "harold"),
              let haroldData = haroldImage.jpegData(compressionQuality: 1) else {
            assertionFailure("No image provided in the assets")
            return .mockedNoImageNoTags
        }

        guard let sheldonImage = UIImage(named: "sheldon"),
              let sheldonData = sheldonImage.jpegData(compressionQuality: 1) else {
            assertionFailure("No image provided in the assets")
            return .mockedNoImageNoTags
        }

        return .init(id: -4, date: Date(timeIntervalSinceNow: -5 * 60), summary: "This is a mocked gratitude entry with both image and tags", images: [gratitudeData, haroldData, sheldonData], tags: [.mocked, .mocked2, .mocked3, .mocked4])
    }
}
