//
//  MainView.swift
//  Volume
//
//  Created by Daniel Vebman on 11/30/20.
//  Copyright © 2020 Cornell AppDev. All rights reserved.
//

import AppDevAnalytics
import AppDevAnnouncements
import SwiftUI

struct MainView: View {
    @State private var selectedTab: Tab = .home
    @EnvironmentObject private var networkState: NetworkState

    init() {
        let grayColor = UIColor(Color.volume.navigationBarGray)
        UINavigationBar.appearance().backgroundColor = grayColor
        UINavigationBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundColor = grayColor
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.volume.lightGray)
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            TabContainer(networkScreen: .homeList) {
                HomeList()
            }
            .tabItem {
                Image("volume")
            }
            .tag(Tab.home)
            TabContainer(networkScreen: .publicationList) {
                PublicationList()
            }
            .tabItem {
                Image("publications")
            }
            .tag(Tab.publications)

            TabContainer(networkScreen: .bookmarksList) {
                BookmarksList()
            }
            .tabItem {
                Image("bookmark")
            }
            .tag(Tab.bookmarks)
        }
        .accentColor(Color.volume.orange)
        .onAppear {
            SwiftUIAnnounce.presentAnnouncement { presented in
                if presented {
                    AppDevAnalytics.log(VolumeEvent.announcementPresented.toEvent(.general))
                }
            }
        }
    }
}

extension MainView {
    /// An enum to keep track of which tab the user is currently on
    private enum Tab {
        case bookmarks, home, publications
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
