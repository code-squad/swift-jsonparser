//
//  Extensions.swift
//  JSONParser
//
//  Created by rhino Q on 2018. 3. 29..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true":
            return true
        case "False", "false":
            return false
        default:
            return nil
        }
    }
}
