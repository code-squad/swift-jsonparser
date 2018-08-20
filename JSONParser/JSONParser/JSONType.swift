//
//  JSONType.swift
//  JSONParser
//
//  Created by 이동건 on 13/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol JSONType {
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


struct JSONArray: JSONType {
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
    
    init(values: JSONValueType) {
        self.values = values
    }
}

struct JSONObject: JSONType {
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
    
    init(values: JSONValueType) {
        self.values = values
    }
}
