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
        case NUMBER = " [0-9]+"
        case COMMA = ","
        static let order = [STARTSQUAREBRACKET, ENDSQUAREBRACKET, NUMBER, STRING, BOOLEAN, COMMA]
    }
    enum JsonError: Error {
        case invalidJsonPattern
    }
    
    func scanOfJsonValue(jsonValue: String) throws -> [Token] {
        var token = [Token]()
        for index in regex.order {
            do {
                let lex = try NSRegularExpression(pattern: index.rawValue)
                let matches = lex.matches(in: jsonValue, range: NSMakeRange(0, jsonValue.count))
                for match in matches {
                    let range = match.range
                    let value = (jsonValue as NSString).substring(with: range)
                    if index == regex.NUMBER || index == regex.STRING || index == regex.BOOLEAN {
                        token.append(Token(id: index, value: value))
                    }
                }
            } catch {
                throw JsonError.invalidJsonPattern
            }
        }
        return token
    }

}
