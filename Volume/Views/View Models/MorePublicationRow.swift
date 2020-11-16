//
//  PublicationRow.swift
//  Volume
//
//  Created by Cameron Russell on 10/29/20.
//  Copyright © 2020 Cornell AppDev. All rights reserved.
//

import SwiftUI

/// `MorePublicationRow`displays the basis information about a publications the user is not currently following
struct MorePublicationRow: View {
    let publication: Publication
    
    @State private var didAddPublication = false
    @State private var expanded = false
    @State private var spacing: CGFloat = 12
    
    var body: some View {
        HStack {
            VStack {
                Image(publication.image)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
                    .padding(.leading)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Creme de Cornell")
                    .font(.custom("Futura-Medium", size: 18))
                    .foregroundColor(.black)
                Text(publication.description)
                    .font(.custom("Helvetica-Regular", size: 12))
                    .foregroundColor(Color(white: 151/255))
                    .truncationMode(.tail)
                    .lineSpacing(4)
                    .background(GeometryReader { geometry in
                        Color.clear.onAppear {
                            self.determineTruncation(geometry)
                        }
                    })
                    .lineLimit(self.expanded ? 2 : 1)
                HStack {
                    Text("|")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(white: 225 / 255))
                    Text("\"\(publication.recent)\"")
                        .font(.custom("Helvetica-Regular", size: 12))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                .padding(.top, 2)
                Spacer()
            }
            
            Spacer()
            
            VStack {
                Button(action: {
                    self.didAddPublication.toggle()
                    // TODO: Add to list of subscribers
                }) {
                    Image(didAddPublication ? "followed" : "follow")
                }
                Spacer()
            }
        }
        .frame(height: expanded ? 98 + spacing : 80 + spacing)
    }
    
    private func determineTruncation(_ geometry: GeometryProxy) {
        let total = publication.description.boundingRect(
                with: CGSize(width: geometry.size.width, height: .greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin,
                attributes: [.font: UIFont.systemFont(ofSize: 11)],
                context: nil
            )

        if total.size.height > geometry.size.height {
            self.expanded = true
        }
    }
}

struct MorePublicationRow_Previews: PreviewProvider {
    static var previews: some View {
        MorePublicationRow(publication: publicationsData[0])
        MorePublicationRow(publication: publicationsData[1])
    }
}
