//
//  Header.swift
//  Volume
//
//  Created by Cameron Russell on 11/15/20.
//  Copyright © 2020 Cornell AppDev. All rights reserved.
//

import SwiftUI

struct Header: View {
    private let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        UnderlinedText(text)
            .font(.begumMedium(size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header("Header")
    }
}
