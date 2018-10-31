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
        return "{\n\(self.map { "\t\"\($0.key)\": \($0.value.prettyPrinted)" } .joined(separator: ",\n"))\n}"
    }

    var prettyPrintedNested: String {
        return "{\n\(self.map { "\t\t\"\($0.key)\": \($0.value.prettyPrinted)" } .joined(separator: ",\n"))\n\t}"
    }
}

extension Array: JSONData where Element == JSONData {
    var typeName: String {
        return "배열"
    }

    var prettyPrinted: String {
        if self.contains(where: { element in return element is [String: JSONData]}) {
            return "[\(self.map { "\($0 is [String: JSONData] ? ($0 as! [String: JSONData]).prettyPrintedNested : $0.prettyPrinted)" } .joined(separator: ",\n\t"))\n]"
        }
        return "[\(self.map { "\($0.prettyPrinted)" } .joined(separator: ", "))]"
    }
}
