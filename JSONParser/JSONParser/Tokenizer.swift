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
    static func parse(_ target: String) throws -> [String] {
        var value = target
        var values:[String] = []
        var token = ""
        var isString = false
        var isObject = false
        var isArray = false
        var doubleQuoteCount = 0 // " " 속 " 를 판단하기 위해
        
        if target.first == Components.arrayOpener.value && target.last == Components.arrayCloser.value {
            value.removeFirst()
            value.removeLast()
        }
        
        for particle in value {
            switch particle {
            case Components.arrayOpener.value:          // 배열의 시작
                if !isString {
                    isArray = !isArray
                }
                token += String(particle)
            case Components.arrayCloser.value:
                token += String(particle)
                if !isString {
                    isArray = !isArray
                }
            case Components.comma.value:
                if isString && doubleQuoteCount % 2 == 1 {
                    isString = false                    // "의 개수가 홀수라면 문자열이 끝났음에도 그 다음을 문자열로 판단하기 때문에 
                }
                
                if isString || isObject || isArray {
                    token += String(particle)           // 문자열의 일부이거나 객체라면 토큰에 추가
                }else {
                    values.append(token)                // 배열이 끝났거나 ,로 구분되었으니 토큰을 저장
                    token = ""
                    doubleQuoteCount = 0
                }
            case Components.objectOpener.value:
                if !isString {                          // 문자열의 일부라면 토큰에 추가
                    isObject = !isObject
                }
                token += String(particle)
            case Components.objectCloser.value:
                token += String(particle)
                if isObject {
                    isObject = !isObject                // 현재 객체의 토큰 값이 진행중이라면 객체가 끝났다는 것을 의미
                }
            case Components.doubleQuote.value:
                isString = !isString                    // 문자열의 시작과 끝을 의미
                token += String(particle)
                doubleQuoteCount += 1
            case Components.space.value:
                if isString || isObject || isArray {    // 문자열의 일부이거나 객체라면 토큰에 추가
                    token += String(particle)
                }
            default:
                token += String(particle)
            }
        }
        if token != "" {
            values.append(token)
        }
        if values.count == 0 {
            throw JSONParserError.invalidInput
        }
        return values
    }
}
