//
//  Utility.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct Utility {
    static func removeFromFirstToEnd(in value: String) -> String {
        let startIndex = value.index(value.startIndex, offsetBy: 1)
        let endIndex = value.index(value.endIndex, offsetBy: -1)
        return String(value[startIndex..<endIndex])
    }
}
