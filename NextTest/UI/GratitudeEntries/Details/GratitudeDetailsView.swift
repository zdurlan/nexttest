//
//  GratitudeDetailsView.swift
//  NextTest
//
//  Created by Alin Zdurlan on 11.03.2024.
//

import SwiftUI

// In mod normal, as face niste extensii pe Float unde as pune diferitele paddinguri, corner radius etc shared prin view-uri
private enum Constants {
    static let verticalSpacing: Double = 12
    static let itemsSpacing: Double = 8
    static let cornerRadius: Double = 5
    static let tagsPadding: Double = 4
    static let toolbarImageSize: Double = 16
    static let smallImageHeight: Double = 45
}

struct GratitudeDetailsView: View {
    @ObservedObject var viewModel: GratitudeDetailsViewModel
    @EnvironmentObject private var navManager: NavigationStateManager
    @EnvironmentObject private var viewModelFactory: GratitudeEntryFactory

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
            GratitudeEntryHeader(viewModel: viewModelFactory.makeEntryViewModel(entry: viewModel.gratitudeEntry, isExpanded: true))

            FlexibleView(data: viewModel.gratitudeEntry.imageArray, spacing: Constants.itemsSpacing, alignment: .leading) { hashedImage in
                hashedImage.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: Constants.smallImageHeight)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
            }

            if viewModel.gratitudeEntry.hasTags {
                FlexibleView(data: viewModel.gratitudeEntry.tags ?? [],
                             spacing: Constants.itemsSpacing,
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

            Spacer()
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    navManager.pop()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back")
                            .font(.headline)
                    }
                }
                .foregroundStyle(.black)
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.editEntry()
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Constants.toolbarImageSize)
                }
                .foregroundStyle(Color.black)
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.deleteEntry()
                } label: {
                    Image(systemName: "trash")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Constants.toolbarImageSize)
                }
                .foregroundStyle(Color.black)
            }
        }
    }
}

#Preview {
    GratitudeDetailsView(viewModel: .init(gratitudeEntry: .mockedNoImageNoTags, controller: GratitudeEntryController(entryService: MockGratitudeEntryService()), navManager: NavigationStateManager()))
}
