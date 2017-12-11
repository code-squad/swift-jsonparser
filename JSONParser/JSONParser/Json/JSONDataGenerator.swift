//
//  File.swift
//  JSONParser
//
//  Created by yuaming on 2017. 12. 8..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONDataGenerator {
    static func unwrapJSONData(in value: JSONData, indent indentLevel: Int) -> String {
        var result: String = ""
        
        switch value {
        case .string(let s):
            result += unwrapString(s)
        case .number(let n):
            result += unwrapNumber(n)
        case .bool(let b):
            result += unwrapBool(b)
        case .array(let a):
            result += unwrapArray(a, indentLevel: indentLevel)
        case .object(let o):
            result += unwrapObject(o, indentLevel: indentLevel)
        default:
            result += unwrapNull()
        }
        
        return result
    }
    
    private static func unwrapString(_ string: String) -> String {
        return string.description
    }
    
    private static func unwrapNumber(_ number: Double) -> String {
        return number.description
    }
    
    private static func unwrapBool(_ bool: Bool) -> String {
        return bool.description
    }
    
    private static func unwrapArray(_ array: [JSONData], indentLevel: Int = 0) -> String {
        var result: [String] = []
        var i: Int = 0
        
        result.append("[")
        result.append(newLine())
        
        for item in array {
            result.append(newSpace(indentLevel + 1))
            result.append(unwrapJSONData(in: item, indent: indentLevel + 1))
            i += 1
            
            if i < array.count {
                result.append(",")
            }
            
            result.append(newLine())
        }
        
        result.append(newSpace(indentLevel))
        result.append("]")
        
        return result.joined()
    }
    
    private static func unwrapObject(_ object: [String: JSONData], indentLevel: Int = 0) -> String {
        var result: [String] = []
        var i: Int = 0
        
        result.append("{")
        result.append(newLine())
        
        for (k, v) in object {
            result.append(newSpace(indentLevel + 1))
            result.append(unwrapString(k))
            result.append(":")
            result.append(" ")
            result.append(unwrapJSONData(in: v, indent: indentLevel + 1))
            
            i += 1
            if i < object.count {
                result.append(",")
                
            }
            
            result.append(newLine())
        }
        
        result.append(newSpace(indentLevel))
        result.append("}")
        
        return result.joined()
    }
 
    private static func unwrapNull() -> String {
        return ""
    }
    
    private static func newLine() -> String {
        return "\n"
    }
    
    private static func newSpace(_ indentLevel: Int) -> String {
        var result: String = ""
        
        for _ in 0..<indentLevel {
            result += "  "
        }
        
        return result
    }
}
