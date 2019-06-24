//
//  Regex.swift
//  JSONParser
//
//  Created by BLU on 23/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Regex {
    private static let string = #"\"[\w ]+\""#
    private static let number = #"[\d]+"#
    private static let bool = "(true|false)"
    private static let whitespaces = " ?"
    
    struct JSON {
        private static let basicValue = "(\(string)|\(number)|\(bool))"
        private static let array = "\\[\(whitespaces)((|,\(whitespaces))(\(basicValue)|(\(whitespaces))))+\(whitespaces)\\]"
        private static let keyValue = "((|,\(whitespaces))(\(string)\(whitespaces):\(whitespaces))(\(basicValue)|\(array)))"
        static let object = "\\{\(whitespaces)\(keyValue)+\(whitespaces)\\}"
        static let nestedArray = "^\\[\(whitespaces)((|,\(whitespaces))((\(basicValue)|\(object))|(\(whitespaces))))+\(whitespaces)\\]*$"
    }
}
