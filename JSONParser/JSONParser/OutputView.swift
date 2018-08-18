//
//  OutputView.swift
//  JSONParser
//
//  Created by 이동건 on 06/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    private static var stageOfObject: Int = 0
    private static var stageOfArray: Int = 0
    
    static func display(_ values: JSONType){
        print(text(from: values))
        print(presentResult(of: values))
    }
    
    static func display(_ error: JSONParserError) {
        print(error)
    }
    
    private static func text(from value: JSONType) -> String {
        var text = ""
        let result = value.result
        text += value.prefix
        
        if result.string > 0 {
            text += " 문자열 \(result.string)개 "
        }
        
        if result.int > 0 {
            text += " 정수 \(result.int)개 "
        }
        
        if result.bool > 0 {
            text += " 부울 \(result.bool)개 "
        }
        
        if result.object > 0 {
            text += " 객체 \(result.object)개 "
        }
        
        if result.array > 0 {
            text += " 배열 \(result.array)개 "
        }
        
        text += "가 존재합니다."
        
        return text
    }
    
    private static func presentResult(of json: JSONType) -> String {
        if json is JSONObject {
            let object = json.values[0]
            return presentValue(from: object)
        }
        
        let array = json.values
        return presentArray(from: array)
    }
    
    private static func presentArray(from array: [JSONValueType]) -> String {
        var text = "\(stageOfArray > 0 ? "\n" : "")\(tab(at: stageOfArray - 1))["
        for (index, element) in array.enumerated() {
            
            switch element {
            case .array(_), .object(_):
                stageOfArray += 1
            default: break
            }
            
            text += presentValue(from: element)
            if index != array.count - 1 {
                text += ","
            }
        }
        text += "]\(stageOfArray > 0 ? "\n" : "")"
        return text
    }
    
    private static func presentObject(from objects: [[String:JSONValueType]]) -> String {
        stageOfObject += 1
        let currentStage = stageOfObject + stageOfArray
        
        var text = "{"
        for (index, object) in objects.enumerated() {
            text += presentPair(from: object, stage: currentStage)
            
            if index != objects.count - 1 {
                text += ","
            }
        }
        
        text += "\n\(tab(at: currentStage - 1))}"
        
        return text
    }
    
    private static func presentPair(from pair: [String:JSONValueType], stage: Int) -> String {
        var text = ""
        let keys = pair.keys.map {String($0)}
        let values = pair.values.map {$0}
        
        text += "\n\(tab(at: stage))\(keys[0]) : \(presentValue(from: values[0]))"
        return text
    }
    
    private static func presentValue(from value: JSONValueType) -> String {
        switch value {
        case .string(let stringValue):
            return stringValue
        case .int(let integerValue):
            return "\(integerValue)"
        case .bool(let booleanValue):
            return "\(booleanValue)"
        case .object(let objectValue):
            return presentObject(from: objectValue)
        case .array(let arrayValue):
            return presentArray(from: arrayValue)
        }
    }
    
    private static func tab(at stage: Int) -> String {
        if stage < 0 {
            return ""
        }
        
        var tabs = ""
        
        for _ in (0..<stage) {
            tabs += "\t"
        }
        
        return tabs
    }
}

