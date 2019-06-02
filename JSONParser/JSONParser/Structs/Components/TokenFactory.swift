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
    
    func create(string: String) -> Token {
        var token: Token
        
        if (string.isNumber) {
            token = Token.Number(Int(string)!)
        }
        else if (string.isBool) {
            token = Token.Bool(Bool(string)!)
        }
        else if (string.isWhiteSpace) {
            token = Token.WhiteSpace
        }
        else if (string.isComma) {
            token = Token.Comma
        }
        else if (string.isDoubleQuotation) {
            token = Token.DoubleQuotation
        }
        else if (string.isString) {
            token = Token.String(string)
        }
        else if (string.isColon) {
            token = Token.Colon
        }
        else if (string.isLeftBrace) {
            token = Token.LeftBrace
        }
        else if (string.isRightBrace) {
            token = Token.RightBrace
        }
        else if (string.isLeftBraket) {
            token = Token.LeftBraket
        }
        else if (string.isRightBraket) {
            token = Token.RightBraket
        }
        else {
            token = Token.Value(string)
        }
        return token
    }
    
}
