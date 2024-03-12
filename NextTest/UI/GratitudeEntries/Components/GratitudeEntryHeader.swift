//
//  GratitudeEntryHeader.swift
//  NextTest
//
//  Created by Alin Zdurlan on 12.03.2024.
//

import SwiftUI

private enum Constants {
    static let verticalSpacing: Double = 12
    static let cornerRadius: Double = 5
    static let imageHeightSmall: Double = 70
    static let imageHeightBig: Double = 140
}

struct GratitudeEntryHeader: View {
    @ObservedObject var viewModel: GratitudeEntryViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                Text(viewModel.entry.dateAsString)
                    .font(.subheadline)
                    .foregroundStyle(Color.grayText)

                Text(viewModel.entry.title)
                    .font(.title3)
                    .lineLimit(2)
                    .foregroundStyle(Color.black)
                    .fontWeight(.semibold)

                if viewModel.entry.hasImage {
                    if let imageToShow = viewModel.entry.mainImage {
                        imageToShow
                            .centerCropped()
                            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                            .frame(height: viewModel.isExpanded ? Constants.imageHeightBig : Constants.imageHeightSmall)
                    }
                }
            }

            Spacer()
        }
    }
}

#Preview {
    GratitudeEntryHeader(viewModel: .init(entry: .mockedNoImageNoTags, isExpanded: true))
}
