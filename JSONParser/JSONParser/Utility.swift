//
//  Utility.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct Utility {
    static func removeFromFirstToEnd(in jsonData: String) -> String {
        let startIndex = jsonData.index(jsonData.startIndex, offsetBy: 1)
        let endIndex = jsonData.index(jsonData.endIndex, offsetBy: -1)
        return String(jsonData[startIndex..<endIndex])
    }
}
