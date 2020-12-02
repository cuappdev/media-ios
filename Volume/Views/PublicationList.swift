//
//  PublicationList.swift
//  Volume
//
//  Created by Cameron Russell on 10/29/20.
//  Copyright © 2020 Cornell AppDev. All rights reserved.
//

import SwiftUI

struct PublicationList: View {
    // The publications a user is following
    private var followedPublications: some View {
        Section {
            Header(text: "Following")
                .padding(.bottom, -12)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(publicationsData) { publication in
                        NavigationLink(destination: PublicationDetail(publication: publication)) {
                            FollowingPublicationRow(publication: publication)
                        }
                    }
                }
                .padding([.leading, .trailing], 10)
            }
        }
    }
    
    // The publications a user is not following
    private var notFollowedPublications: some View {
        Section {
            Header(text: "More Publications")
            ForEach(publicationsData) { publication in
                NavigationLink(destination: PublicationDetail(publication: publication)) {
                    MorePublicationRow(publication: publication)
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing)
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                followedPublications
                Spacer()
                    .frame(height: 48)
                notFollowedPublications
            }
            .background(Color.volume.backgroundGray)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    BubblePeriodText("Publications")
                        .font(.begumMedium(size: 28))
                        .offset(y: 8)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PublicationList_Previews: PreviewProvider {
    static var previews: some View {
        PublicationList()
    }
}
