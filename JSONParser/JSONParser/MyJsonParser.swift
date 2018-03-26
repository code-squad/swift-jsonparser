//
//  MyJsonParser.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 21..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct MyJsonParser {

    func checkBrackets(_ input: String) -> JSONData? {
        if input.hasPrefix("{") {
            let data = separateByComma(input)
            let inputData = separateByColon(data)
            let removeBracketsData = removeBrackets(inputData)
            let removeWhiteSpaceData = removeWhiteSpace(removeBracketsData)
            let castingData = makeDictionary(removeWhiteSpaceData)
            return castingData
        } else if input.hasPrefix("[") {
            let data = separateByBrackets(input)
            return data
        }
        return nil
    }
    
    //콤마 기준으로 나눔
    func separateByComma(_ input: String) -> [String] {
        let inputData = input.components(separatedBy: ",")
        return inputData
    }
    
    //콜론 기준으로 나눔
    func separateByColon(_ input: [String]) -> [String] {
        var inputData: [String] = []
        for data in input {
            inputData += data.components(separatedBy: ":")
        }
        return inputData
    }
    
    //괄호 지우기
    func removeBrackets(_ input: [String]) -> [String] {
        var removeBracketsData:[String] = []
        for data in input {
            removeBracketsData.append(data.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "\"", with: ""))
        }
        return removeBracketsData
    }
    
    //공백 지우기
    func removeWhiteSpace(_ inputData: [String]) -> [String] {
        var data:[String] = []
        for index in 0..<inputData.count {
            data.append(inputData[index].trimmingCharacters(in: .whitespacesAndNewlines))
        }
        return data
    }
    
    //객체 기준으로 나누기
    func separateByBrackets(_ input: String) -> [String] {
        let inputData = input.components(separatedBy: "},")
        return inputData
    }
    
    // 딕셔너리 반환
    func makeDictionary(_ input: [String]) -> [String:Any] {
        var data: [String:String] = [:]
        for index in 0..<input.count {
            if index % 2 == 0 {
                data[input[index]] = input[index+1]
            }
        }
        let castingData = typecasting(data)
        return castingData
    }
    
    // 타입 캐스팅
    func typecasting(_ input: [String:String]) -> [String:Any] {
        var castingData: [String:Any] = [:]
        for (key,value) in input {
            if let boolInput = Bool.init(value) {
                castingData[key] = Bool(boolInput)
            } else if let numberInput = Int.init(value) {
                castingData[key] = Int(numberInput)
            } else {
                castingData[key] = value
            }
        }
        return castingData
    }
    
}


