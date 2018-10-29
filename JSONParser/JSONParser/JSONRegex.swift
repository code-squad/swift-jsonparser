//
//  JSONRegex.swift
//  JSONParser
//
//  Created by 윤지영 on 29/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONRegex {
    private static let space = "\\s"
    private static let colon = ":"
    private static let leftCurlyBracket = "\\{"
    private static let rightCurlyBracket = "\\}"
    private static let leftSquareBracket = "\\["
    private static let rightSquareBracket = "\\]"

    private static let string = "\"[\\w_\(space)]+\""
    private static let int = "[0-9]+"
    private static let bool = "(?:true|false)"

    private static let values = "\(string)|\(int)|\(bool)"
    static let keyValue = "\(string)\(space)*\(colon)\(space)*(?:\(values))"
    private static let object = "\(leftCurlyBracket)\(space)*\(keyValue)\(space)*(?:,\(space)*\(keyValue)\(space)*)*\(rightCurlyBracket)"
    static let jsonObject = "^\(object)$"

    static let valuesIncludingObject = "\(values)|\(object)"
    static let jsonArray = "^\(leftSquareBracket)\(space)*(?:\(valuesIncludingObject))\(space)*(?:,\(space)*(?:\(valuesIncludingObject))\(space)*)*\(rightSquareBracket)$"
}
