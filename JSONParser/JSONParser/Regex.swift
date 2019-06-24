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
    private static let jsonBasicValue = "(\(string)|\(number)|\(bool))"
    private static let jsonArray = "\\[\(whitespaces)((|,\(whitespaces))(\(jsonBasicValue)|(\(whitespaces))))+\(whitespaces)\\]"
    private static let jsonKeyValue = "((|,\(whitespaces))(\(string)\(whitespaces):\(whitespaces))(\(jsonBasicValue)|\(jsonArray)))"
    static let jsonObject = "\\{\(whitespaces)\(jsonKeyValue)+\(whitespaces)\\}"
    static let nestedJSONArray = "^\\[\(whitespaces)((|,\(whitespaces))((\(jsonBasicValue)\(jsonObject))|(\(whitespaces))))+\(whitespaces)\\]*$"
}
