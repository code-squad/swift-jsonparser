//
//  JSONType.swift
//  JSONParser
//
//  Created by 윤지영 on 23/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol JSONData {
    var typeName: String { get }
    var prettyPrinted: String { get }
}

extension String: JSONData {
    var typeName: String {
        return "문자열"
    }

    var prettyPrinted: String {
        return "\"\(self)\""
    }
}

extension Int: JSONData {
    var typeName: String {
        return "숫자"
    }
    
    var prettyPrinted: String {
        return "\(self)"
    }
}

extension Bool: JSONData {
    var typeName: String {
        return "부울"
    }
    
    var prettyPrinted: String {
        return "\(self)"
    }
}

extension Dictionary: JSONData where Key == String, Value == JSONData {
    var typeName: String {
        return "객체"
    }
    
    var prettyPrinted: String {
        let object = self.map { "\t\"\($0.key)\": \($0.value.prettyPrinted)" }
                        .joined(separator: ",\n")
        return "{\n\(object)\n}"
    }

    var prettyPrintedNested: String {
        let objectNested = self.map { "\t\t\"\($0.key)\": \($0.value.prettyPrinted)" }
                                .joined(separator: ",\n")
        return "{\n\(objectNested)\n\t}"
    }
}

extension Array: JSONData where Element == JSONData {
    var typeName: String {
        return "배열"
    }

    var prettyPrinted: String {
        if self.contains(where: { element in return element is [String: JSONData] }) {
            let arrayContainingObject = self.map { "\($0 is [String: JSONData] ? ($0 as! [String: JSONData]).prettyPrintedNested : $0.prettyPrinted)" }
                                            .joined(separator: ",\n\t")
            return "[\(arrayContainingObject)\n]"
        }
        let array = self.map { "\($0.prettyPrinted)" }
                        .joined(separator: ", ")
        return "[\(array)]"
    }
}
