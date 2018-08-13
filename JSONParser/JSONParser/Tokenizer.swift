//
//  Tokenizer.swift
//  JSONParser
//
//  Created by 이동건 on 11/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum Components {
    case arrayOpener
    case arrayCloser
    case objectOpener
    case objectCloser
    case space
    case doubleQuote
    case comma
    case colon
    
    var value: Character {
        switch self {
        case .arrayOpener:
            return "["
        case .arrayCloser:
            return "]"
        case .objectOpener:
            return "{"
        case .objectCloser:
            return "}"
        case .space:
            return " "
        case .doubleQuote:
            return "\""
        case .comma:
            return ","
        case .colon:
            return ":"
        }
    }
}

struct Tokenizer {
    static func parse(_ target: String) -> [String] {
        var values:[String] = []
        var token = ""
        var isString = false
        var isObject = false
        
        for particle in target {
            switch particle {
            case Components.arrayOpener.value:
                if isString || isObject {
                    token += String(particle)
                }
            case Components.arrayCloser.value, Components.comma.value:
                if isString || isObject {
                    token += String(particle)
                }else {
                    values.append(token)
                    token = ""
                }
            case Components.objectOpener.value:
                if !isString {
                    isObject = !isObject
                }
                token += String(particle)
            case Components.objectCloser.value:
                token += String(particle)
                if isObject {
                    isObject = !isObject
                }
                if particle == target.last {
                    values.append(token)
                    token = ""
                }
            case Components.doubleQuote.value:
                isString = !isString
                token += String(particle)
            case Components.space.value:
                if isString || isObject {
                    token += String(particle)
                }
            default:
                token += String(particle)
            }
        }
        return values
    }
}
