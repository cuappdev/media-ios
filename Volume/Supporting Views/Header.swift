//
//  Header.swift
//  Volume
//
//  Created by Cameron Russell on 11/15/20.
//  Copyright © 2020 Cornell AppDev. All rights reserved.
//

import SwiftUI

// TODO: Combine w/ publication PR
struct Header : View {
    
    @State var text: String!
    
    var body : some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
    
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
