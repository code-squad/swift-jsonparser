//
//  ResultData.swift
//  JSONParser
//
//  Created by YOUTH on 2018. 1. 2..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct ResultData {
    
    func decideFormat (_ dataType: JSONData) -> String {
        if case let JSONData.ArrayValue(dataType) = dataType {
            return listResult(dataType)
        }
        if case let JSONData.ObjectValue(dataType) = dataType {
            return objectResult(dataType, depth: 1)
        }
        return ""
    }
    
    private func objectResult (_ values: [String:JSONData], depth: Int) -> String {
        var text = ""
        text += "{"
        text += makeNewLine()
        for key in values.keys {
            text += makeDepth(depth) + "\(key) : \(String(describing: values[key])), "
            text += makeNewLine()
        }
        text += makeDepth(depth) + "}"
        text += makeNewLine()
        return text
    }
    
    private func nestedArray (_ value: [JSONData], depth: Int) -> String {
        var text = ""
        text += makeDepth(depth)
        text += String(describing: value)
        text += makeNewLine()
        
        return text
    }
    
    private func listResult (_ values: [JSONData]) -> String {
        var text = ""
        text += "["
        for value in values {
            if case let JSONData.ArrayValue(value) = value {
                text += nestedArray(value, depth: 1)
            }
            if case let JSONData.ObjectValue(value) = value {
                text += objectResult(value, depth: 2)
            }
        }
        text += "]"
        return text
    }
    
    private func makeDepth(_ depth: Int) -> String{
        return String(repeating: "\t", count: depth)
    }
    
    private func makeNewLine() -> String {
        return "\n"
    }
    
}
