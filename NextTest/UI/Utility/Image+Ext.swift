//
//  Image+Ext.swift
//  NextTest
//
//  Created by Alin Zdurlan on 12.03.2024.
//

import SwiftUI

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}
