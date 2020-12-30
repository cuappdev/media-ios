//
//  PublicationDetail.swift
//  Volume
//
//  Created by Cameron Russell on 10/29/20.
//  Copyright © 2020 Cornell AppDev. All rights reserved.
//

import SwiftUI

/// `PublicationDetail` displays detailed information about a publication
struct PublicationDetail: View {
    let publication: Publication
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            PublicationHeader(publication: publication)
                .padding(.bottom)
            
            Divider()
                .background(Color(white: 238 / 255))
                .frame(width: 100)

            Header(text: "Articles")
            LazyVStack {
                ForEach(Array(Set(publication.articles))) { article in
                    ArticleRow(article: article, showsPublicationName: false)
                        .padding([.bottom, .leading, .trailing])
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
        
    }
}

//struct PublicationDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        PublicationDetail(
//            publication: Publication(
//                description: "A publication bringing you only the collest horse facts.",
//                name: "Guac",
//                id: "asdfsf39201sd923k",
//                imageURL: nil,
//                recent: "Horses love to swim"
//            )
//        )
//    }
//}
