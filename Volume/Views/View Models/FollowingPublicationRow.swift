//
//  PublicationRow.swift
//  Volume
//
//  Created by Cameron Russell on 10/29/20.
//  Copyright © 2020 Cornell AppDev. All rights reserved.
//

import SwiftUI

/// `FollowingPublicationRow` displays the imagse and name of a publication a user is currently following
struct FollowingPublicationRow: View {
    
    var publication: Publication
        
    var body: some View {
        VStack {
            Image(publication.image)
                .resizable()
                .clipShape(Circle())
                .shadow(color: Color(white: 0, opacity: 0.1), radius: 5)
                .frame(width: 75, height: 75)
                .padding(.top)  // so shadow doesn't cut off
            Text(publication.name)
                .font(.custom("Futura-Medium", size: 12))
                .foregroundColor(.black)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
            Spacer()
        }
        .frame(width: 90, height: 150)
    }
}

struct FollowingPublicationRow_Previews: PreviewProvider {
    static var previews: some View {
        FollowingPublicationRow(publication: publicationsData[0])
    }
}
