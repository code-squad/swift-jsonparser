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
        self.prettyData.append(contentsOf: addValuesOfData())
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
    
    // 데이터별 개행 규칙
    // 기본 : 데이터 내부(X) / 외부(X)
    // 배열 : 데이터 내부(X) / 외부(O) - 윗줄 개행 후 시작.
    // 객체 : 데이터 내부(O) / 외부(X)
    private func addValuesOfData() -> [Any] {
        var prettyDataBuffer: [Any] = ["["]
        var isBasicPreceded = false
        var isArrayPreceded = false
        for index in 0..<self.data.count {
            let datum = self.data[index]
            var isLastDatum = false
            if index == self.data.count - 1 { isLastDatum = true }
            switch datum {
            case let objectDatum as TYPEObject:
                let prettyObject = makePrettyData(objectDatum, isLastDatum, isArrayPreceded)
                prettyDataBuffer.append(contentsOf: prettyObject)
                isArrayPreceded = false
                break
            case let arrayDatum as TYPEArray:
                let prettyArray = makePrettyData(arrayDatum, isLastDatum, isBasicPreceded)
                prettyDataBuffer.append(contentsOf: prettyArray)
                isArrayPreceded = true
                break
            default:
                let prettyBasic = makePrettyData(datum, isLastDatum, isArrayPreceded)
                prettyDataBuffer.append(contentsOf: prettyBasic)
                isBasicPreceded = true
                break
            }
            // 마지막 원소인 경우, 전체배열 대괄호 닫음.
            if isLastDatum {
                prettyDataBuffer.append("]")
            }else {
                // 마지막 원소가 아니면 콤마.
                prettyDataBuffer.append(",")
            }
        }
        return prettyDataBuffer
    }
    
    private func makePrettyData(_ datum: TYPEObject, _ isLastDatum: Bool, _ isArrayPreceded: Bool) -> [Any] {
        var temp: [Any] = []
        // 외부 개행 없음.
        temp.append("{")
        // 내부 데이터 각각에 개행 적용.
        for (key, var value) in datum {
            let data = makeDataString(from: value)
            temp.append("\n\t")
            temp.append("\t\"\(key)\":\(value)")
            temp.append(",")
        }
        // 배열 내부 마지막 콤마 제거.
        temp.removeLast()
        // 내부 개행 후 객체 괄호 닫음.
        temp.append("\n\t}")
        if isArrayPreceded && isLastDatum {
            temp.append("\n")
        }
        return temp
    }
    
    private func makePrettyData(_ datum: TYPEArray, _ isLastDatum: Bool, _ isBasicPreceded: Bool) -> [Any] {
        var temp: [Any] = []
        // 문자열이면 따옴표 붙임.
        let elem = makeDataString(from: datum)
        // 윗줄 개행 후 시작. 단순 문자열로 시작하는 경우엔 개행 안 함.
        if !isBasicPreceded {
            temp.append("\n\t")
        }
        // 내부 원소는 개행 없음.
        temp.append(elem)
        if !isBasicPreceded && isLastDatum {
            temp.append("\n")
        }
        return temp
    }
    
    private func makePrettyData(_ datum: Any, _ isLastDatum: Bool, _ isArrayPreceded: Bool) -> [Any] {
        var temp: [Any] = []
        // 문자열이면 따옴표 붙임.
        let elem = makeDataString(from: datum)
        temp.append(elem)
        if isArrayPreceded && isLastDatum {
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
    
}
