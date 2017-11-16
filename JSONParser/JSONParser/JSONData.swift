//
//  JSONData.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONData {
    typealias Number = Int
    typealias Array = [Any]
    enum DataType {
        case array
        case object
    }
    // 데이터 타입 저장. - Array, Object
    private(set) var dataType: DataType
    // 각 데이터를 타입별로 저장.
    private(set) var objectString: [String:String]
    private(set) var objectNumber: [String:Number]
    private(set) var objectBool: [String:Bool]
    private(set) var objectArray: [String:Array]
    // object 항목의 array 데이터.
    private(set) var arrayString: [String]
    private(set) var arrayNumber: [Number]
    private(set) var arrayBool: [Bool]
    private(set) var arrayInner: [Array]
    // 전체 데이터 개수.
    var count: Int {
        var result = 0
        switch dataType {
        case .array: result = self.arrayString.count + self.arrayNumber.count + self.arrayBool.count + self.arrayInner.count
        case .object: result = self.objectString.count + self.objectNumber.count + self.objectBool.count + self.objectArray.count
        }
        return result
    }
    var innerArrayCount = 0
    var innerObjectCount = 0
    
    mutating func setInnerBlobCount() {
        var isObject: Bool = false
        for blob in self.arrayInner {
            for elem in blob {
                if type(of: elem) == (key: String, value: Any).self {
                    isObject = true
                }
            }
            if isObject {
                self.innerObjectCount += 1
                isObject = false
            }
        }
        self.innerArrayCount = self.arrayInner.count - self.innerObjectCount
    }
    
    init() {
        self.dataType = DataType.array
        self.objectString = [:]
        self.objectNumber = [:]
        self.objectBool = [:]
        self.objectArray = [:]
        self.arrayString = []
        self.arrayNumber = []
        self.arrayBool = []
        self.arrayInner = []
    }
    
    mutating func setData(_ data: [String:Any]) {
        self.dataType = DataType.object
        for (key, value) in data {
            switch value {
            case is String:
                guard let stringValue = value as? String else { break }
                self.objectString.updateValue(stringValue, forKey: key)
            case is Number:
                guard let numberValue = value as? Number else { break }
                self.objectNumber.updateValue(numberValue, forKey: key)
            case is Bool:
                guard let boolValue = value as? Bool else { break }
                self.objectBool.updateValue(boolValue, forKey: key)
            case is Array:
                guard let arrayValue = value as? Array else { break }
                self.objectArray.updateValue(arrayValue, forKey: key)
            default: return
            }
        }
        setInnerBlobCount()
    }
    
    mutating func setData(_ data: [Any]) {
        self.dataType = DataType.array
        for value in data {
            switch value {
            case is String:
                guard let stringValue = value as? String else { break }
                self.arrayString.append(stringValue)
            case is Number:
                guard let numberValue = value as? Number else { break }
                self.arrayNumber.append(numberValue)
            case is Bool:
                guard let boolValue = value as? Bool else { break }
                self.arrayBool.append(boolValue)
            case is Array:
                guard let arrayValue = value as? Array else { break }
                self.arrayInner.append(arrayValue)
            default: return
            }
        }
        setInnerBlobCount()
    }
    
}
