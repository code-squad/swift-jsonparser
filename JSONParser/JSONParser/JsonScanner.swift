//
//  JsonScanner.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JsonScanner {
    enum regex: String {
        case STARTSQUAREBRACKET = "\\["
        case ENDSQUAREBRACKET = "\\]"
        case STARTCURLYBRACKET = "\\{"
        case ENDCURLYBRACKET = "\\}"
        case STRING = "\"[a-z,A-Z,0-9, ]+\""
        case BOOLEAN = "(true|false)"
        case NUMBER = "[0-9]+"
        case COMMA = "\\,"
        case COLON = "\\:"
        static let order = [STARTSQUAREBRACKET, ENDSQUAREBRACKET, STARTCURLYBRACKET, ENDCURLYBRACKET, NUMBER, STRING, BOOLEAN, COMMA, COLON]
    }
    enum JsonError: Error {
        case invalidJsonPattern
    }
    
    func scanOfJsonValue(jsonValue: String) throws -> [Token] {
        var token = [Token]()
        let regexOfWhole = "(\"[^\"\"]*\")|(false|true)|(\\{|\\})|(\\[|\\])|(:)|(\\,)|(\\d+)"
        let lex = try NSRegularExpression(pattern: regexOfWhole)
        let mathes = lex.matches(in: jsonValue, range: NSMakeRange(0, jsonValue.count))
        // split each token
        for match in mathes {
            let range = match.range
            let valueOfRange = (jsonValue as NSString).substring(with: range) // 10, "Jk"
            // matching each type
            for index in regex.order {
                let lexOfType = try NSRegularExpression(pattern: index.rawValue)
                let matchesOfType = lexOfType.firstMatch(in: valueOfRange, range: NSMakeRange(0, valueOfRange.count))
                if matchesOfType != nil {
                    let rangeOfType = matchesOfType?.range
                    var value: Any = ""
                    if index == regex.NUMBER {
                        value = Int((valueOfRange as NSString).substring(with: rangeOfType!)) as Any
                    }else if index == regex.BOOLEAN {
                        value = Bool((valueOfRange as NSString).substring(with: rangeOfType!)) as Any
                    }else if index == regex.STRING {
                        value = String((valueOfRange as NSString).substring(with: rangeOfType!))
                    }
                    token.append(Token(id: index, value: value))
                }
            }
        }
        return token
    }

}
