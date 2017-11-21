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
        case ENDSQUAREBRACKET = "]"
        case STRING = "\"[a-z,A-Z,0-9]+\""
        case BOOLEAN = "(true|false)"
        case NUMBER = " [0-9]+"
        case COMMA = ","
        
        static let order = [STARTSQUAREBRACKET, ENDSQUAREBRACKET, NUMBER, STRING, BOOLEAN, COMMA]
    }
    
    func scanOfJsonValue(jsonValue: String) -> [TokenInfo] {
        var token = [TokenInfo]()
        for index in regex.order {
            do {
                let lex = try NSRegularExpression(pattern: index.rawValue)
                let matches = lex.matches(in: jsonValue, range: NSMakeRange(0, jsonValue.count))
                for match in matches {
                    let range = match.range
                    let value = (jsonValue as NSString).substring(with: range)
                    let id = String(describing: index)
                    if id == "NUMBER" || id == "STRING" || id == "BOOLEAN" {
                        token.append(TokenInfo(id: String(describing: id), value: value))
                    }
                }
            } catch {
                
            }
        }
        return token
    }
    
    func getToken() {
        
    }
}
