//
//  ResultData.swift
//  JSONParser
//
//  Created by YOUTH on 2018. 1. 2..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct ResultData {
    
    func make(_ dataForResult: JSONData) -> String {
        var resultText = ""
        resultText += selectType(dataForResult)
        resultText.removeLast()
        return resultText
    }
    
    private func selectType(_ dataForResult: JSONData) -> String {
        var resultText = ""
        if case let JSONData.ArrayValue(dataForResult) = dataForResult {
            resultText += listText(dataForResult, 0)
            resultText += "]"
            return resultText
        }
        if case let JSONData.ObjectValue(dataForResult) = dataForResult {
            resultText += objectText(dataForResult, 0)
            resultText += "}"
            return resultText
        }
        return ""
    }
    
    private func listText(_ values: [JSONData], _ depth: Int) -> String {
        var resultText = ""
        resultText += makeDepth(depth)
        resultText += "["
        for value in values {
            resultText += "\(makeValueText(value)), "
        }
        resultText.removeLast(2)
        resultText += "]"
        return resultText
    }
    
    private func objectText(_ values: [String:JSONData], _ depth: Int) -> String {
        var resultText = ""
        resultText += "{"
        resultText += makeNewLine()
        
        for key in values.keys {
            let valueInObject = values[key] ?? JSONData.IntegerValue(0)
            resultText += makeDepth(depth+1) + "\(key) : \(makeValueText(valueInObject))"
            resultText += ","
            resultText += makeNewLine()
        }
        resultText.removeLast(2)
        resultText += makeNewLine()
        resultText += makeDepth(depth)
        resultText += "}"
        
        return resultText
    }
    
    private func makeValueText (_ value: JSONData) -> String {
        switch value {
        case let .IntegerValue(value): return String(describing: value)
        case let .StringValue(value): return String(describing: value)
        case let .BoolValue(value): return String(describing: value)
        case let .ObjectValue(value): return objectText(value, 1) + makeNewLine()
        case let .ArrayValue(value): return listText(value, 1) + makeNewLine()
        }
    }
    
    private func makeDepth(_ depth: Int) -> String{
        return String(repeating: "\t", count: depth)
    }
    
    private func makeNewLine() -> String {
        return "\n"
    }

}

