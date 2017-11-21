//
//  JSONArray.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 22..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONArray: JSONData {
    var data: TYPEArray
    var dataCountOfEach: (string: Int, number: Int, bool: Int, nestedObject: Int, nestedArray: Int)
    var prettyData: [Any]
    var count: Int { return data.count }
    
    init(data: TYPEArray) {
        self.data = []
        self.dataCountOfEach = (0,0,0,0,0)
        self.prettyData = []
        setData(data)
        setCounts()
        makePrettyData()
    }
    
    mutating func setData(_ data: TYPEArray) {
        for value in data {
            self.data.append(value)
        }
    }
    
    mutating func setCounts() {
        for value in data {
            setEachCounts(of: value)
        }
    }
    
    mutating func makePrettyData() {
        self.prettyData.append("[")
        self.prettyData.append(contentsOf: addValuesOfData())
        self.prettyData.append("]")
    }
    
    func addValuesOfData() -> [Any] {
        var temp: [Any] = []
        var isNotNormalData = false
        for datum in self.data {
            switch datum {
            case let values as [String:Any]:
                temp.append("{")
                for (key, value) in values {
                    let data = makeDataString(from: value)
                    appendAnys(to: &temp, of: "\n\t\t\"", key, "\": ", data, ",")
                }
                temp.append("\n\t},")
                isNotNormalData = true
                break
            case let values as [Any]:
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
    
}
