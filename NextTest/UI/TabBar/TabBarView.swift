//
//  TabBarView.swift
//  NextTest
//
//  Created by Alin Zdurlan on 11.03.2024.
//

import SwiftUI

enum Tab {
    case supportGroups, dailyGratitude
}

struct TabBarView: View {
    @StateObject private var navManager = NavigationStateManager()

    @State private var selectedTab: Tab = .dailyGratitude

    let viewModelFactory = GratitudeEntryFactory()

    var body: some View {
        TabView(selection: tabSelection()) {
            Group {
                SupportGroupView()
                    .tag(Tab.supportGroups)
                    .tabItem {
                        Label("Support Groups", systemImage: "arrow.up.heart")
                    }

                TimelineView(viewModel: viewModelFactory.makeTimelineViewModel())
                    .environmentObject(navManager)
                    .environmentObject(viewModelFactory)
                    .tag(Tab.dailyGratitude)
                    .tabItem {
                        Label("Daily Gratitude", systemImage: "calendar")
                    }
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.white, for: .tabBar)
        }
    }
}

extension TabBarView {
    private func tabSelection() -> Binding<Tab> {
        Binding { // this is the get block
            self.selectedTab
        } set: { tappedTab in
            if tappedTab == self.selectedTab {
                popToRootOnTab(tappedTab)
            }

            self.selectedTab = tappedTab
        }
    }

    func popToRootOnTab(_ tab: Tab) {
        navManager.popToRoot()
    }
}

#Preview {
    TabBarView()
}
