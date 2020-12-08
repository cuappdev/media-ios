//
//  ArticleInfo.swift
//  Volume
//
//  Created by Cameron Russell on 10/30/20.
//  Copyright © 2020 Cornell AppDev. All rights reserved.
//

import SwiftUI

struct ArticleInfo: View {
    let article: Article
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(article.publication.name)
                    .font(.begumMedium(size: 12))
                Text(article.title)
                    .font(.helveticaBold(size: 16))
                    .lineLimit(3)
                    .padding(.top, 0.5)
                Spacer()
                HStack {
                    Text("\(article.date.fullString) • \(article.shoutOuts) shout-outs")
                        .font(.helveticaRegular(size: 10))
                        .foregroundColor(Color.volume.lightGray)
                    if article.isSaved {
                        Image(systemName: "bookmark.fill")
                            .resizable()
                            .foregroundColor(Color.volume.orange)
                            .frame(width: 8, height: 11)
                    }
                }
            }
            Spacer()
        }
    }
}

//struct ArticleInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleInfo(
//            article: Article(
//                articleURL: nil,
//                date: Date(),
//                id: "a",
//                imageURL: nil,
//                publication: Publication(
//                    description: "CU",
//                    name: "CUNooz",
//                    id: "sdfsdf",
//                    imageURL: nil,
//                    recent: "Sandpaper Tastes Like What?!"
//                ),
//                shoutOuts: 14,
//                title: "Children Discover the Meaning of Christmas"
//            )
//        )
//    }
//}
