//
//  StringUtility.swift
//  JSONParser
//
//  Created by BLU on 18/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct StringUtility {
    static func removeDoubleQuotations(_ value: String) -> String {
        if value.first == "\"" && value.last == "\"" {
            return String(value.dropFirst().dropLast())
        }
        return value
    }
}
