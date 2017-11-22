//
//  JSONArray.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 22..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONArray: JSONData {
    init(data: TYPEArray) {
        self.data = []
        self.dataCountOfEach = (0,0,0,0,0)
        self.prettyData = []
        setData(data)
        setCounts()
        makePrettyData()
    }
    private var data: TYPEArray
    var dataCountOfEach: (string: Int, number: Int, bool: Int, nestedObject: Int, nestedArray: Int)
    var prettyData: [Any]
    var count: Int { return data.count }
    
    private mutating func setData(_ data: TYPEArray) {
        for value in data {
            self.data.append(value)
        }
    }
    
    private mutating func setCounts() {
        for value in self.data {
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
        self.prettyData.append("[")
        self.prettyData.append(contentsOf: addValuesOfData())
        self.prettyData.append("]")
    }
    
    private func addValuesOfData() -> [Any] {
        var temp: [Any] = []
        var isNotNormalData = false
        for datum in self.data {
            switch datum {
            case let values as TYPEObject:
                temp.append("{")
                for (key, value) in values {
                    let data = makeDataString(from: value)
                    appendAnys(to: &temp, of: "\n\t\t\"", key, "\": ", data, ",")
                }
                temp.append("\n\t},")
                isNotNormalData = true
                break
            case let values as TYPEArray:
                let elem = makeDataString(from: values)
                if self.dataCountOfEach.nestedObject != 0 {
                    temp.append("\n\t")
                }
                appendAnys(to: &temp, of: elem, ",")
                isNotNormalData = false
                break
            default:
                let elem = makeDataString(from: datum)
                appendAnys(to: &temp, of: " ", elem, ",")
                isNotNormalData = false
                break
            }
        }
        if isNotNormalData {
            temp.append("\n")
        }
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
