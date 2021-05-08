//
//  DebriefArticleView.swift
//  Volume
//
//  Created by Cameron Russell on 5/7/21.
//  Copyright © 2021 Cornell AppDev. All rights reserved.
//

import SwiftUI

struct DebriefArticleView: View {
    let article: Article
    
    var iconRow: some View {
        HStack {
            DebriefIcon(systemName: "bookmark")
            DebriefIcon(systemName: "square.and.arrow.up")
            DebriefIcon(iamgeName: "shout-out")
        }
    }
    
    var body: some View {
        Group {
            WebImage(url: article.imageUrl)
                .resizable()
                .grayBackground()
                .aspectRatio(contentMode: .fill)
                .frame(width: 275, height: 275)
                .clipped()
            
            Text(article.publication.name)
            
            Text(article.title)
            
            ArticleMetaData(article: article)
            
        }
    }
}


struct DebriefIcon: View {
    let imageName: String? = nil
    let systemName: String? = nil

    var body: some View {
        ZStack {
            Circle()
            
            Image("shout-out")
                .resizable()
                .scaledToFit()
                .frame(height: 24)
                .foregroundColor(Color.gray)
        }
    }
}

struct DebriefArticleView_Previews: PreviewProvider {
    static var previews: some View {
        DebriefArticleView()
    }
}
