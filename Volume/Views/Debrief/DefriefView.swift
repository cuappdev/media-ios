//
//  DefriefArticleView.swift
//  Volume
//
//  Created by Cameron Russell on 5/7/21.
//  Copyright © 2021 Cornell AppDev. All rights reserved.
//

import SwiftUI

struct DefriefView: View {
    var body: some View {
        VStack {
            Image("volume-logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .padding([.leading, .trailing], 65)
                .padding(.top, 25)
                .matchedGeometryEffect(id: volumeLogoID, in: namespace)

            Group {
                switch page {
                case .overview:
                    Text("Welcome to Volume")
                case .article:
                    Text("Follow student publications that you are interested in")
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                case .goodbye:
                    Text("")
                }
            }
            
            switch page {
            case .overview:
                DebriefWelcomeView()
            case .follow:
                DebriefArticleView()
            case .goodbye:
                DebriefGoodbyeView()
            }
            
            Spacer()

            PageControl(currentPage: page == .overview ? 0 : 1, numberOfPages: 6) // TODO: fix this
                .padding(.bottom, 47)
            
        }
    }
}

extension DebriefView {
    enum Page {
        case overview, article, goodbye
    }

    struct PageControl: View {
        private let selectedColor = Color(white: 153 / 255)
        private let unselectedColor = Color(white: 196 / 255)

        let currentPage: Int
        let numberOfPages: Int

        var body: some View {
            HStack(spacing: 12) {
                ForEach(0..<numberOfPages) { i in
                    Circle()
                        .fill(i == currentPage ? selectedColor : unselectedColor)
                        .frame(width: 6, height: 6)
                }
            }
        }
    }
}

//struct DefriefArticleView_Previews: PreviewProvider {
//    static var previews: some View {
//        DefriefArticleView()
//    }
//}
