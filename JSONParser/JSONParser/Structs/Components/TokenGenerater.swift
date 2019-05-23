//
//  TokenGenerater.swift
//  JSONParser
//
//  Created by 이동영 on 23/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TokenGenerater {
    
    static public func createToken(_ string: String) -> Token {
        let nomalized = self.normalize(string)
        let type = determinType(value: nomalized)
        return Token.init(type: type, value: nomalized)
    }
    
    private static func normalize(_ string: String) -> String {
        var normalized = string
        normalizeFirst(&normalized)
        normalizeLast(&normalized)
        return normalized
    }
    
    private static func normalizeFirst(_ string: inout String){
        if(Symbols.whiteSpace == string.first){
            string.removeFirst()
        }
    }
    
    private static func normalizeLast(_ string: inout String){
        if([Symbols.comma,Symbols.whiteSpace].contains(string.last)){
            string.removeLast()
        }
    }
    
    private static func determinType(value:String) -> TokenType {
        return TokenType.of(value)
    }
    
    
}
