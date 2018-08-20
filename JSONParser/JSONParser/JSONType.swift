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
    
    func presentableValue(stage: Int) -> String {
        switch self {
        case .string(let stringValue):
            return stringValue
        case .int(let intValue):
            return "\(intValue)"
        case .bool(let boolValue):
            return "\(boolValue)"
        case .array(let array):
            let json = JSONArray(values: self)
            return json.presentArray(from: array, stage: stage)
        case .object(let object):
            let json = JSONObject(values: self)
            return json.presentObject(from: object, stage: stage)
        }
    }
}

class PrettyJSONDiscripter {
    
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
        let stage = result.int > 0 || result.bool > 0 || result.int > 0 ? 0 : 1
        return values.presentableValue(stage: stage)
    }()
    
    init(values: JSONValueType) {
        self.values = values
    }
    
    func presentArray(from array: [JSONValueType], stage: Int) -> String {
        var text = "["
        for (index, item) in array.enumerated() {
            switch item {
            case .array(_):
                text += "\(stage > 0 ? "\n" : "")\(tab(at: stage))\(item.presentableValue(stage: stage + 1))\(stage > 0 ? "\n" : "")"
            case .object(_):
                text += "\(item.presentableValue(stage: stage + 1))"
            default:
                text += item.presentableValue(stage: stage)
            }
            if index != array.count - 1 {
                text += ","
            }
        }
        text += "]"
        return text
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
        return values.presentableValue(stage: 1)
    }()
    
    init(values: JSONValueType) {
        self.values = values
    }
    
    func presentObject(from objects: [[String:JSONValueType]], stage: Int) -> String {
        var text = "{\n"
        for (index, pair) in objects.enumerated() {
            let pairString = presentPair(from: pair, stage: stage)
            text += pairString
            if index != objects.count - 1 {
                text += ","
            }
            text += "\n"
        }
        text += "\(tab(at: stage == 1 ? 0 : stage - 1))}"
        return text
    }
    
    func presentPair(from pair: [String:JSONValueType], stage: Int) -> String {
        var text = ""
        let keys = pair.keys.map {String($0)}
        let values = pair.values.map {$0}
        
        switch values[0] {
        case .array(_), .object(_):
            text += "\(tab(at: stage))\(keys[0]) : \(values[0].presentableValue(stage: stage + 1))"
        default:
            text += "\(tab(at: stage))\(keys[0]) : \(values[0].presentableValue(stage: stage))"
        }
        return text
    }
}
