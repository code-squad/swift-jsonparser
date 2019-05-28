//
//  MyTokenizer.swift
//  JSONParser
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MyTokenizer: Tokenizer {
    let json: String
    var scanner: MyScanner
    
    init(json: String){
        self.json = json
        self.scanner = MyScanner.init(string: json)
    }
    
    func tokenize() throws -> [Token] {
        var tokens = [Token]()
        tokens.append(Token.Comma)
        return tokens
    }
    
    mutating func split() throws -> [String] {
        var units = [String]()
        
        while let character = self.scanner.next(){
            switch character {
            case "[":
                ()
            case "]":
                ()
            case "\"":
                ()
            case ",":
                ()
            case " ":
                ()
            case "0"..."9":
                ()
            default:
                ()
            }
        }
        return units
    }
    
    mutating func getNumber() -> String {
        self.scanner.backCurser()
        var number = ""
        while let character = self.scanner.next() {
            if (character.isNumber){
                number = "\(number)\(character)"
                continue
            }
        }
        self.scanner.backCurser()
        return number
    }
    
    mutating func getValue() -> String {
        self.scanner.backCurser()
        var value = ""
        while let character = self.scanner.next() {
            if !(character.isWhitespace || character.isPunctuation){
                value = "\(value)\(character)"
                continue
            }
        }
        self.scanner.backCurser()
        return value
    }
    
}
