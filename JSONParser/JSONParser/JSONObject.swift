//
//  JSONObject.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 22..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONObject: JSONData {
    init(data: TYPEObject) {
        self.data = [:]
        self.dataCountOfEach = (0,0,0,0,0)
        self.prettyData = []
        setData(data)
        setCounts()
        makePrettyData()
    }
    private var data: TYPEObject
    var dataCountOfEach: (string: Int, number: Int, bool: Int, nestedObject: Int, nestedArray: Int)
    var prettyData: [Any]
    var count: Int { return data.count }
    
    private mutating func setData(_ data: TYPEObject) {
        for (key, value) in data {
            self.data.updateValue(value, forKey: key)
        }
    }
    
    private mutating func setCounts() {
        for value in self.data.values {
            setEachCounts(of: value)
        }
    }
    
    private mutating func setEachCounts(of datum: Any) {
        switch datum {
        case is TYPEString: self.dataCountOfEach.string += 1
        case is TYPENumber: self.dataCountOfEach.number += 1
        case is TYPEBool: self.dataCountOfEach.bool += 1
        case is TYPEArray: self.dataCountOfEach.nestedArray += 1
        case is TYPEObject: self.dataCountOfEach.nestedObject += 1
        default: break
        }
    }

    private mutating func makePrettyData() {
        self.prettyData.append("{")
        self.prettyData.append(contentsOf: addValuesOfData())
        self.prettyData.append("\n")
        self.prettyData.append("}")
    }
    
    // 데이터별 개행 규칙
    // 기본 : 데이터 내부(X) / 외부(X)
    // 배열 : 데이터 내부(X) / 외부(O) - 윗줄 개행 후 시작.
    // 객체 : 데이터 내부(O) / 외부(X)
    private func addValuesOfData() -> [Any] {
        var temp: [Any] = []
        for (key, value) in self.data {
            switch value {
            case let values as TYPEObject:
                temp.append("\n\t\"\(key)\": {")
                for (key, value) in values {
                    // 데이터가 문자열이면 따옴표 붙임.
                    let data = makeDataString(from: value)
                    temp.append("\n\t\t\"\(key)\": \(data),")
                }
                temp.removeLast()
                temp.append("\n\t}")
                temp.append(",")
                break
            case let values as TYPEArray:
                let data = makeDataString(from: values)
                temp.append("\n\t\"\(key)\": \(data)")
                temp.append(",")
                break
            default:
                let data = makeDataString(from: value)
                temp.append("\n\t\"\(key)\": \(data)")
                temp.append(",")
                break
            }
        }
        temp.removeLast()
        return temp
    }
    
    private func makeDataString(from data: Any) -> Any {
        switch data {
        case let value as String:
            return "\"" + value + "\""
        default:
            return data
        }
    }
    
    private func appendAnys(to dest: inout [Any], of datum: Any...) {
        dest.append(contentsOf: datum)
    }
    
}

