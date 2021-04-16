//
//  SettingsView.swift
//  Volume
//
//  Created by Cameron Russell on 4/12/21.
//  Copyright © 2021 Cornell AppDev. All rights reserved.
//

import SwiftUI

struct Settings {
    enum NestedView: String {
        case aboutUs = "aboutUs"
    }
        
    static let pages = [
        Page(destination: .externalLink(Secrets.feedbackForm), imageName: "flag", info: "Send Feedback"),
        Page(destination: .externalLink("https://www.cornellappdev.com/"), imageName: "link", info: "Visit Our Website"),
        Page(destination: .internalView("aboutUs"), imageName: "info", info: "About Us"),
    ]
    
    static func getView(for view: NestedView) -> some View {
        switch view {
        case .aboutUs:
            return AboutUsView()
        }
    }
}

struct Page: Identifiable {
    let id = UUID()
    
    let destination: Destination
    let imageName: String
    let info: String
    
    enum Destination {
        case externalLink(String)
        case internalView(String)
    }
}

struct SettingsView: View {
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Begum-Medium", size: 20)!]
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach (0..<Settings.pages.count) { index in
                SettingsPageRow(page: Settings.pages[index])
            }
        }
        .navigationBarTitle(Text("Settings"), displayMode: .inline)
        .background(Color.volume.backgroundGray)
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
