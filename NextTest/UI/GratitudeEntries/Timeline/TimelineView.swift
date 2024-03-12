//
//  TimelineView.swift
//  NextTest
//
//  Created by Alin Zdurlan on 11.03.2024.
//

import SwiftUI

private enum Constants {
    static let toolbarImageSize: Double = 16
}

struct TimelineView: View {
    @ObservedObject var viewModel: TimelineViewModel
    @EnvironmentObject private var navManager: NavigationStateManager
    @EnvironmentObject private var viewModelFactory: GratitudeEntryFactory

    var body: some View {
        NavigationStack(path: $navManager.routes) {
            VStack {
                if viewModel.isLoading {
                    ProgressView() // in mod normal asta ar fi un modifier
                } else {
                    List {
                        Group {
                            Section {
                                ForEach(viewModel.recentEntries, id: \.id) { entry in
                                    GratitudeEntryView(viewModel: viewModelFactory.makeEntryViewModel(entry: entry, isExpanded: false))
                                        .onTapGesture {
                                            navManager.goToDetails(gratitude: entry)
                                        }
                                }
                            } header: {
                                Text("This week") // Astea ar fi intr-un localizable
                                    .textCase(nil)
                            }

                            Section {
                                ForEach(viewModel.olderEntries, id: \.id) { entry in
                                    GratitudeEntryView(viewModel: viewModelFactory.makeEntryViewModel(entry: entry, isExpanded: false))
                                        .onTapGesture {
                                            navManager.goToDetails(gratitude: entry)
                                        }
                                }
                            } header: {
                                Text("Last month")
                                    .textCase(nil)
                            }
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                    }
                    .scrollIndicators(.hidden)
                    .listStyle(.plain)
                    .listRowSpacing(10)
                    .padding(.horizontal)
                    .safeAreaInset(edge: .bottom, content: {
                        Spacer().frame(height: 20)
                    })
                    .background(.almostWhiteBackground)
                }
            }
            .onAppear() {
                viewModel.getEntries()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Daily Gratitude")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // TODO: Go to charts
                    } label: {
                        Image(systemName: "chart.pie")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: Constants.toolbarImageSize)
                    }
                    .foregroundStyle(Color.black)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // TODO: Add a new entry
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: Constants.toolbarImageSize)
                    }
                    .foregroundStyle(Color.black)
                }
            }
            .navigationDestination(for: CoreNavigationPath.self) { type in
                switch type {
                case .details(let gratitudeEntry):
                    GratitudeDetailsView(viewModel: viewModelFactory.makeDetailsViewModel(gratitudeEntry: gratitudeEntry, navManager: navManager))
                    .toolbar(.hidden, for: .tabBar)
                    .environmentObject(navManager)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TimelineView(viewModel: .init(controller: GratitudeEntryController(entryService: MockGratitudeEntryService())))
            .environmentObject(NavigationStateManager())
            .environmentObject(GratitudeEntryFactory())
    }
}
