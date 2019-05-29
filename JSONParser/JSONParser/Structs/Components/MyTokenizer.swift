//
//  MyTokenizer.swift
//  JSONParser
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MyTokenizer: Tokenizer {
    var scanner: MyScanner
    let factory = MyTokenFactory()
    
    init(_ string: String) {
        self.scanner = MyScanner.init(string: string)
    }
    
    mutating func tokenize() throws -> [Token] {
        let units = try self.split()
        let tokens = units.map{ self.factory.createToken(string: $0 )}
        return tokens
    }
    
    private mutating func split() throws -> [String] {
        var units = Array<String>()
        
        while let character = self.scanner.next() {
            switch character {
            case "[","]",","," ",
                 "\"",":","{","}":
                units.append(String(character))
            case "0"..."9":
                units.append(getNumber())
                self.scanner.backCurser()
            default:
                units.append(getValue())
                self.scanner.backCurser()
            }
        }
        return units
    }
    
    private mutating func getNumber() -> String {
        var number = ""
        self.scanner.backCurser()
        while let character = self.scanner.next() {
            if (character.isNumber) {
                number = "\(number)\(character)"
                continue
            }
            break
        }
        return number
    }
    
    private mutating func getValue() -> String {
        var value = ""
        self.scanner.backCurser()
        while let character = self.scanner.next() {
            if !(character.isWhitespace || character.isPunctuation){
                value = "\(value)\(character)"
                continue
            }
            break
        }
        return value
    }
    
}
