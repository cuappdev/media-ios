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
        Text("Publication Detail")
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
