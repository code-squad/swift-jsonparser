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
        var values:[String] = []
        var token = ""
        var isString = false
        var isObject = false
        
        for particle in target {
            switch particle {
            case Components.arrayOpener.value:                          // 배열의 시작
                if isString {
                    token += String(particle)                           // 문자열의 일부라면 토큰에 추가
                }
            case Components.arrayCloser.value, Components.comma.value:
                if isString || isObject {
                    token += String(particle)                           // 문자열의 일부이거나 객체라면 토큰에 추가
                }else {
                    values.append(token)                                // 배열이 끝났거나 ,로 구분되었으니 토큰을 저장
                    token = ""
                }
            case Components.objectOpener.value:
                if !isString {                                          // 문자열의 일부라면 토큰에 추가
                    isObject = !isObject
                }
                token += String(particle)
            case Components.objectCloser.value:
                token += String(particle)
                if isObject {
                    isObject = !isObject                                // 현재 객체의 토큰 값이 진행중이라면 객체가 끝났다는 것을 의미
                }
                if particle == target.last {
                    values.append(token)                                // 단일 객체라면 }가 마지막, 토큰에 추가되어 있던 값을 저장
                    token = ""
                }
            case Components.doubleQuote.value:
                isString = !isString                                    // 문자열의 시작과 끝을 의미
                token += String(particle)
            case Components.space.value:
                if isString || isObject {                               // 문자열의 일부이거나 객체라면 토큰에 추가
                    token += String(particle)
                }
            default:
                token += String(particle)
            }
        }
        if values.count == 0 {
            throw JSONParserError.invalidInput
        }
        return values
    }
}
