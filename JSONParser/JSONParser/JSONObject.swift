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
    
    mutating func setCounts() {
        for value in data.values {
            setEachCounts(of: value)
        }
    }

    mutating func makePrettyData() {
        self.prettyData.append("{")
        self.prettyData.append(contentsOf: addValuesOfData())
        self.prettyData.append("\n")
        self.prettyData.append("}")
    }
    
    func addValuesOfData() -> [Any] {
        var temp: [Any] = []
        for (key, value) in self.data {
            switch value {
            case let values as TYPEObject:
                appendAnys(to: &temp, of: "\n\t\"", key, "\": ", "{")
                for (key, value) in values {
                    // 데이터가 문자열이면 따옴표 붙임.
                    let data = makeDataString(from: value)
                    appendAnys(to: &temp, of: "\n\t\t\"", key, "\": ", data, ",")
                }
                temp.append("\n\t},")
                break
            case let values as TYPEArray:
                let data = makeDataString(from: values)
                appendAnys(to: &temp, of: "\n\t\"", key, "\": ", data, ",")
                break
            default:
                let data = makeDataString(from: value)
                appendAnys(to: &temp, of: "\n\t\"", key, "\": ", data, ",")
                break
            }
        }
        return temp
    }
    
}
