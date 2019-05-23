//
//  Context2.swift
//  JSONParser
//
//  Created by 이동영 on 23/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum Context: Character {
    typealias RawValue = Character
    
    case Array = "["
    case Value = " "
    case String = "\""
    
    func canInclude(context: Context) -> Bool {
        switch self {
        case .Array:
            return context == .Value || context == .Array
        case .Value:
            return context != .Value
        case .String:
            return false
        }
    }
    
    func isFinish(inCaseOf: Character) -> Bool {
        switch self {
        case .Array:
            return inCaseOf == Symbols.closeBracket
        case .Value:
            return [Symbols.closeBracket,Symbols.comma,Symbols.whiteSpace].contains(inCaseOf)
        case .String:
            return inCaseOf == Symbols.doubleQuotation
        }
    }
    
    
}
