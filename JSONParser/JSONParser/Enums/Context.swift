//
//  Context.swift
//  JSONParser
//
//  Created by 이동영 on 21/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

typealias StartSymbol = Character
typealias EndSymbol = Character

enum Context: StartSymbol {
    
    case Array = "["
    case Value = " "
    case String = "\""
    
    func isStart(_ char: Character) -> Bool {
        var startSymbols = [StartSymbol]()
        
        switch self {
        case .Array:
            startSymbols.append(Symbols.whiteSpace)
            startSymbols.append(Symbols.openBracket)
        case .Value:
            startSymbols.append(Symbols.doubleQuotation)
        case .String:
            ()
        }
        return startSymbols.contains(char)
    }
    
    func isEnd(_ char: Character) -> Bool {
        var endSymbols = [EndSymbol]()
        
        switch self {
        case .Value:
            endSymbols.append(Symbols.comma)
            fallthrough
        case .Array:
            endSymbols.append(Symbols.closeBracket)
        case .String:
            endSymbols.append(Symbols.doubleQuotation)
        }
        return endSymbols.contains(char)
    }
    
}


