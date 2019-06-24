//
//  Regex.swift
//  JSONParser
//
//  Created by BLU on 23/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Regex {
    struct JSON {
        private static let string = #"\"[\w ]+\""#
        private static let number = #"[\d]+"#
        private static let bool = "(true|false)"
        private static let whitespaces = " ?"
        private static let basicValue = "(\(string)|\(number)|\(bool))"
        private static let array = "\\[\(whitespaces)((|,\(whitespaces))(\(basicValue)|(\(whitespaces))))+\(whitespaces)\\]"
        private static let object = "\\{\(whitespaces)((|,\(whitespaces))(\(string)\(whitespaces):\(whitespaces))(\(basicValue)|\(array)))+\(whitespaces)\\}"
        static let nestedArray = "^\\[\(whitespaces)((|,\(whitespaces))((\(basicValue)|\(array))|(\(whitespaces))))+\(whitespaces)\\]*$"
        static let nestedObject = "\\{\(whitespaces)((|,\(whitespaces))(\(string)\(whitespaces):\(whitespaces))(\(basicValue)|\(array)|\(object)))+\(whitespaces)\\}"
    }
}
