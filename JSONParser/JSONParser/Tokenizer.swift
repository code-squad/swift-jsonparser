//
//  Tokenizer.swift
//  JSONParser
//
//  Created by 이동건 on 11/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct Tokenizer {
    private let arrayOpener: Character = "["
    private let arrayCloser: Character = "]"
    private let objectOpener: Character = "{"
    private let objectCloser: Character = "}"
    private let space: Character = " "
    private let doubleQuote: Character = "\""
    private let comma: Character = ","
    
    private var target: String
    
    init(target: String) {
        self.target = target
    }
    
    func parse() -> [String] {
        var values:[String] = []
        var token = ""
        var isString = false
        var isObject = false
        
        for particle in target {
            switch particle {
            case arrayOpener:
                if isString || isObject {
                    token += String(particle)
                }
            case arrayCloser, comma:
                if isString || isObject {
                    token += String(particle)
                }else {
                    values.append(token)
                    token = ""
                }
            case objectOpener:
                if !isString {
                    isObject = !isObject
                }
                token += String(particle)
            case objectCloser:
                token += String(particle)
                if isObject {
                    isObject = !isObject
                }
                if particle == target.last {
                    values.append(token)
                    token = ""
                }
            case doubleQuote:
                isString = !isString
                token += String(particle)
            case space:
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
