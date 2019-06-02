//
//  JSON.swift
//  JSONParser
//
//  Created by 이동영 on 02/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum JSON {
    case Number(Int)
    case String(String)
    case Bool(Bool)
    case List(Array<JSON>)
    case Object(Dictionary<String, JSON>)
}


extension JSON: ExpressibleByIntegerLiteral {
   
    init(integerLiteral value: Int) {
        self = .Number(value)
    }
    
}

extension JSON: ExpressibleByStringLiteral {
    
    init(stringLiteral value: String) {
        self = .String(value)
    }
}

extension JSON: ExpressibleByBooleanLiteral {
   
    init(booleanLiteral value: Bool) {
        self = .Bool(value)
    }
    
}

extension JSON: ExpressibleByArrayLiteral {
    
    init(arrayLiteral elements: JSON...) {
        self = .List(elements)
    }
}

extension JSON: ExpressibleByDictionaryLiteral {
   
    init(dictionaryLiteral elements: (String, JSON)...) {
        var dic = Dictionary<String, JSON>()
        _ = elements.map {
            dic[$0] = $1
        }
        self = .Object(dic)
    }
}
