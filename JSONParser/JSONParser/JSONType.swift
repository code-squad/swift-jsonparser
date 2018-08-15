//
//  JSONType.swift
//  JSONParser
//
//  Created by 이동건 on 13/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol JSONType {
    var values: [JSONValueType] { set get }
    var prefix: String { get }
    var result: (string:Int, int:Int, bool:Int, object: Int, array: Int) { get }
}


enum JSONValueType {
    case string(String)
    case int(Int)
    case bool(Bool)
    case object([String:JSONValueType])
    case array([JSONValueType])
}


struct JSONArray: JSONType {
    var prefix: String {
        return "배열안에는"
    }
    var values: [JSONValueType] = []
    
    var result: (string: Int, int: Int, bool: Int, object: Int, array: Int) {
        var string = 0
        var int = 0
        var bool = 0
        var object = 0
        var array = 0
        
        values.forEach {
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
        
        return (string, int, bool, object, array)
    }
}

struct JSONObject: JSONType {
    var prefix: String {
        return "객체안에는"
    }
    var values: [JSONValueType] = []
    
    var result: (string: Int, int: Int, bool: Int, object: Int, array: Int) {
        var string = 0
        var int = 0
        var bool = 0
        var object = 0
        var array = 0
        
        switch values[0] {
        case .object(let jsonObject):
            jsonObject.values.forEach { (type) in
                switch type {
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
}
