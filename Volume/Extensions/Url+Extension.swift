//
//  Url+Extension.swift
//  Volume
//
//  Created by Sergio Diaz on 4/26/21.
//  Copyright © 2021 Cornell AppDev. All rights reserved.
//
import Foundation

extension URL {
    var parameters: [String: String] {
        if  let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems {
            var parameters = [String: String]()
            for item in queryItems {
                parameters[item.name] = item.value ?? ""
            }
            return parameters
        } else {
            return [:]
        }
    }
}
