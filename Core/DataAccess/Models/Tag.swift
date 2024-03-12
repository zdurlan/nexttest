//
//  Tag.swift
//  NextTest
//
//  Created by Alin Zdurlan on 11.03.2024.
//

import Foundation

struct Tag: Codable, Hashable {
    let id: Int
    let name: String
}

extension Tag {
    static var mocked: Tag {
        .init(id: -1, name: "MockedTag")
    }

    static var mocked2: Tag {
        .init(id: -2, name: "MockedTag2")
    }

    static var mocked3: Tag {
        .init(id: -3, name: "MockedTag3")
    }

    static var mocked4: Tag {
        .init(id: -4, name: "MockedTag4")
    }
}
