//
//  MyTokenFactory.swift
//  JSONParser
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TokenFactory: Factory {
    typealias T = Token
    
    func create(string: String) -> Token? {
        var token: Token?
        
        if (string.isNumber) {
            token = Token.number(Int(string)!)
        }
        else if (string.isBool) {
            token = Token.bool(Bool(string)!)
        }
        else if (string.isString) {
            token = Token.string(String(string.dropFirst().dropLast()))
        }
        else if (string.isWhiteSpace) {
            token = Token.ws
        }
        else if (string.isComma) {
            token = Token.comma
        }
        else if (string.isDoubleQuotation) {
            token = Token.doubleQuotation
        }
        else if (string.isColon) {
            token = Token.colon
        }
        else if (string.isLeftBrace) {
            token = Token.leftBrace
        }
        else if (string.isRightBrace) {
            token = Token.rightBrace
        }
        else if (string.isLeftBraket) {
            token = Token.leftBraket
        }
        else if (string.isRightBraket) {
            token = Token.rightBraket
        }
        return token
    }
    
}
