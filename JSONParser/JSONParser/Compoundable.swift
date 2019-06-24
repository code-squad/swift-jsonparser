//
//  Compoundable.swift
//  JSONParser
//
//  Created by Daheen Lee on 24/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Compoundable {
    var elementCount: Int { get }
    var elements: [JSONValue] { get }
    func formatted(indentLevel: Int) -> String
    func getFormatted(element: JSONValue, indent: Int) -> String
}

}

extension Array: Compoundable where Element == JSONValue {
    var elementCount: Int {
        return self.count
    }
    
    var elements: [JSONValue] {
        return self
    }
}

extension Dictionary: Compoundable where Key == String, Value == JSONValue {
    var elementCount: Int {
        return self.count
    }
    
    var elements: [JSONValue] {
        return Array(self.values)
    }
    
}
