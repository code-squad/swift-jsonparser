//
//  MyTokenFactory.swift
//  JSONParser
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MyTokenFactory: TokenFactory {
    
    func createToken(string: String) -> Token {
        var token: Token
        
        if (isNumber(string)) {
            token = Token.Number(Int(string)!)
        }
        else if (isBool(string)) {
            token = Token.Bool(Bool(string)!)
        }
        else if (isWhiteSpace(string)) {
            token = Token.WhiteSpace
        }
        else if (isComma(string)) {
            token = Token.Comma
        }
        else if (isDoubleQuotation(string)) {
            token = Token.DoubleQuotation
        }
        else if (isLeftBraket(string)) {
            token = Token.LeftBraket
        }
        else if (isRightBraket(string)) {
            token = Token.RightBraket
        }
        else {
            token = Token.Value(string)
        }
        return token
    }
    
    private func isNumber(_ string: String) -> Bool {
        return Int(string) != nil
    }
    
    private func isBool(_ string: String) -> Bool {
        return Bool(string) != nil
    }
    
    private func isString(_ string: String) -> Bool {
        return string.first == "\"" && string.last == "\""
    }
    
    private func isWhiteSpace(_ string: String) -> Bool {
        return string == " "
    }
    
    private func isComma(_ string: String) -> Bool {
        return string == ","
    }
    
    private func isDoubleQuotation(_ string: String) -> Bool {
        return string == "\""
    }
    
    private func isLeftBraket(_ string: String) -> Bool {
        return string == "["
    }
    
    private func isRightBraket(_ string: String) -> Bool {
        return string == "]"
    }
    
}
