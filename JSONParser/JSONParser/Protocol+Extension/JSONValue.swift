//
//  JSON.swift
//  JSONParser
//
//  Created by BLU on 2019. 6. 2..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

protocol JSONValue {
    var typeDescription: String { get }
}

protocol JSONSerializable {
    func serialize() -> String
}

extension String: JSONValue, JSONSerializable {
    var typeDescription: String {
        return "문자열"
    }
    
    func serialize() -> String {
        return "\"\(self)\""
    }
}

extension Int: JSONValue, JSONSerializable {
    var typeDescription: String {
        return "숫자"
    }
    
    func serialize() -> String {
        return "\(self)"
    }
}

extension Bool: JSONValue, JSONSerializable {
    var typeDescription: String {
        return "부울"
    }
    
    func serialize() -> String {
        return "\(self)"
    }
}
