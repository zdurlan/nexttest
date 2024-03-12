//
//  GratitudeEntryView.swift
//  NextTest
//
//  Created by Alin Zdurlan on 11.03.2024.
//

import SwiftUI

private enum Constants {
    static let verticalSpacing: Double = 12
    static let tagsSpacing: Double = 8
    static let imageHeight: Double = 70
    static let cornerRadius: Double = 5
    static let tagsPadding: Double = 4
}

struct GratitudeEntryView: View {
    @ObservedObject var viewModel: GratitudeEntryViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
            GratitudeEntryHeader(viewModel: viewModel)

            if viewModel.entry.hasTags {
                FlexibleView(data: viewModel.entry.tags ?? [],
                             spacing: Constants.tagsSpacing,
                             alignment: .leading) { tag in
                    Text("#\(tag.name)")
                        .font(.footnote)
                        .foregroundStyle(Color.grayText)
                        .padding(Constants.tagsPadding)
                        .overlay(
                            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                                .stroke(.grayText, lineWidth: 1)
                        )
                }
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
    }
}

#Preview {
    GratitudeEntryView(viewModel: .init(entry: .mockedNoImageNoTags, isExpanded: false))
}
