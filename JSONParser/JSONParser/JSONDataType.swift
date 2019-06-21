//
//  JSONDataType.swift
//  JSONParser
//
//  Created by 이희찬 on 11/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JSONValue {
    var typeDescription: String { get }
}

extension String: JSONValue {
    var typeDescription: String { return "StringType" }
    
    func isString() -> Bool {
        return TypeCriterion.String.isStrictSubset(of: CharacterSet(charactersIn: self))
    }
    
    func isInt() -> Bool {
        return CharacterSet(charactersIn: self).isStrictSubset(of: TypeCriterion.Int)
    }
    
    func isBool() -> Bool {
        return self == TypeCriterion.Bool.true || self == TypeCriterion.Bool.false
    }
}

extension Int: JSONValue {
    var typeDescription: String { return "IntType" }
}

extension Bool: JSONValue {
    var typeDescription: String { return "BoolType" }
}


