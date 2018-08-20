//
//  JSONType.swift
//  JSONParser
//
//  Created by 이동건 on 13/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol JSONType {
    var text: String { get }
    var values: JSONValueType { set get }
    var prefix: String { get }
    var result: (string:Int, int:Int, bool:Int, object: Int, array: Int) { get }
}

enum JSONValueType {
    case string(String)
    case int(Int)
    case bool(Bool)
    case object([[String:JSONValueType]])
    case array([JSONValueType])
}

class PrettyJSONDiscripter {
    var stageOfArray: Int = 0
    var stageOfObject: Int = 0
    
    func presentArray(from array: [JSONValueType]) -> String {
        let stage = stageOfArray > 1 ? stageOfArray - 1 : stageOfArray
        var text = "\(stageOfArray > 0 ? "\n" : "")\(tab(at: stage))["
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
    
    func presentObject(from objects: [[String:JSONValueType]]) -> String {
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
    
    func presentPair(from pair: [String:JSONValueType], stage: Int) -> String {
        var text = ""
        let keys = pair.keys.map {String($0)}
        let values = pair.values.map {$0}
        
        text += "\n\(tab(at: stage))\(keys[0]) : \(presentValue(from: values[0]))"
        return text
    }
    
    func presentValue(from value: JSONValueType) -> String {
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
    
    func tab(at stage: Int) -> String {
        if stage <= 0 {
            return ""
        }
        
        var tabs = ""
        
        for _ in (0..<stage) {
            tabs += "\t"
        }
        
        return tabs
    }

}

class JSONArray: PrettyJSONDiscripter, JSONType {
    var prefix: String {
        return "배열안에는"
    }
    var values: JSONValueType
    
    var result: (string: Int, int: Int, bool: Int, object: Int, array: Int) {
        var string = 0
        var int = 0
        var bool = 0
        var object = 0
        var array = 0
        
        switch values {
        case .array(let jsonValues):
            jsonValues.forEach {
                switch $0 {
                case .string(_):
                    string += 1
                case .int(_):
                    int += 1
                case .bool(_):
                    bool += 1
                case .object(_):
                    object += 1
                case .array(_):
                    array += 1
                }
            }
        default: break
        }
        
        return (string, int, bool, object, array)
    }
    
    lazy var text: String = {
        return presentValue(from: values)
    }()
    
    init(values: JSONValueType) {
        self.values = values
    }
}

class JSONObject: PrettyJSONDiscripter, JSONType {
    var prefix: String {
        return "객체안에는"
    }
    var values: JSONValueType
    
    var result: (string: Int, int: Int, bool: Int, object: Int, array: Int) {
        var string = 0
        var int = 0
        var bool = 0
        var object = 0
        var array = 0
        
        switch values {
        case .object(let objects):
            objects.forEach {
                let objectValues = $0.values.map {$0}
                switch objectValues[0] {
                case .string(_):
                    string += 1
                case .int(_):
                    int += 1
                case .bool(_):
                    bool += 1
                case .object(_):
                    object += 1
                case .array(_):
                    array += 1
                }
            }
        default: break
        }
        // 단일 객체이므로 객체의 값은 0으로 반환
        return (string, int, bool, object, array)
    }
    
    lazy var text: String = {
        return presentValue(from: values)
    }()
    
    init(values: JSONValueType) {
        self.values = values
    }
}
