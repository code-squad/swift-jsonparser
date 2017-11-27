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
        case STRING = "\"[a-z,A-Z,0-9]+\""
        case BOOLEAN = "(true|false)"
        case NUMBER = "[0-9]+"
        case COMMA = ","
        static let order = [STARTSQUAREBRACKET, ENDSQUAREBRACKET, NUMBER, STRING, BOOLEAN, COMMA]
    }
    enum JsonError: Error {
        case invalidJsonPattern
    }
    
    func scanOfJsonValue(jsonValue: String) throws -> [Token] {
        var token = [Token]()
        let regexOfwhole = "([\\d+\\w\"(true|false)\\[\\]]+)"
        let lex = try NSRegularExpression(pattern: regexOfwhole)
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
                    let value = (valueOfRange as NSString).substring(with: rangeOfType!)
                    print(index, value)
                    token.append(Token(id: index, value: value))
                }
            }
        }
        return token
    }

}
