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
    private(set) var dataCountOfEach: (string: Int, number: Int, bool: Int, nestedObject: Int, nestedArray: Int)
    private var prettyData: [Any]
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
    
    func generateJSONReport() -> String {
        let dataType = "객체"
        // 전체 데이터 개수 (문자열, 숫자, 부울, 객체, 배열)
        let dataCounts = self.dataCountOfEach
        
        // 출력할 문자열.
        var result = "총 \(data.count)개의 \(dataType) 데이터 중에"
        if dataCounts.string > 0 {
            result += " 문자열 \(dataCounts.string)개,"
        }
        if dataCounts.number > 0 {
            result += " 숫자 \(dataCounts.number)개,"
        }
        if dataCounts.bool > 0 {
            result += " 부울 \(dataCounts.bool)개,"
        }
        if dataCounts.nestedObject > 0 {
            result += " 객체 \(dataCounts.nestedObject)개,"
        }
        if dataCounts.nestedArray > 0 {
            result += " 배열 \(dataCounts.nestedArray)개,"
        }
        result.removeLast()             // 마지막 콤마(,) 제거.
        result += "가 포함되어 있습니다."
        return result
    }
    
    func generatePrettyJSONData() -> String {
        var resultData = ""
        for datum in self.prettyData {
            resultData += "\(datum) "
        }
        resultData += "\n"
        return resultData
    }
    
}

