//
//  JSONData.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONData {
    typealias JSONObject = [String:Any]
    typealias JSONArray = [Any]
    typealias JSONString = String
    typealias JSONNumber = Int
    typealias JSONBool = Bool
    enum DataType {
        case array
        case object
    }
    // 데이터 타입 저장. - Array, Object
    private(set) var dataType: DataType
    // 각 데이터를 타입별로 저장.
    private(set) var object: JSONObject
    // object 항목의 array 데이터.
    private(set) var array: JSONArray
    // 데이터별 개수 저장.
    private(set) var dataCountOfEach: (string: Int, number: Int, bool: Int, nestedObject: Int, nestedArray: Int) = (0, 0, 0, 0, 0)
    // 전체 데이터 개수.
    var count: Int {
        var result = 0
        switch dataType {
        case .array: result = self.array.count
        case .object: result = self.object.count
        }
        return result
    }
    
    init() {
        self.dataType = DataType.array
        self.object = [:]
        self.array = []
    }
    
    mutating func setData(_ data: JSONObject) {
        self.dataType = DataType.object
        for (key, value) in data {
            self.object.updateValue(value, forKey: key)
        }
        setCounts(of: data)
    }
    
    mutating func setData(_ data: JSONArray) {
        self.dataType = DataType.array
        for value in data {
            self.array.append(value)
        }
        setCounts(of: data)
    }
    
    // 전체데이터가 객체 타입일 때 내부 데이터들의 개수 세팅.
    private mutating func setCounts(of objects: JSONObject) {
        for value in objects.values {
            setEachCounts(of: value)
        }
    }
    
    private mutating func setCounts(of arrays: JSONArray) {
        for value in arrays {
            setEachCounts(of: value)
        }
    }
    
    private mutating func setEachCounts(of element: Any) {
        switch element {
        case is JSONString: self.dataCountOfEach.string += 1
        case is JSONNumber: self.dataCountOfEach.number += 1
        case is JSONBool: self.dataCountOfEach.bool += 1
        case is JSONArray: self.dataCountOfEach.nestedArray += 1
        case is JSONObject: self.dataCountOfEach.nestedObject += 1
        default: break
        }
    }
    
}
