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
            let jsonData = checkColonAndBrackets(input)
            return jsonData
        } else if input.hasPrefix("[") {
            let dropBracketsData = dropBrackets(input)
            let arrayCount = countOfArrayData(dropBracketsData)
            let objectCount = countOfObjectData(dropBracketsData)
            let arrayData = makeArrayData(input)
            let jsonData = ArrayData.init(arrayCount,objectCount,arrayData.array,arrayData.dictionary)
            return jsonData
        }
        return nil
    }
    
    /* inputValue start [ */
    //시작과 끝 괄호 [] drop
    private func dropBrackets(_ inputString: String) -> String {
        let dropFirst = inputString.dropFirst()
        let dropLast = dropFirst.dropLast()
        return String(dropLast)
    }
    
    //배열 카운트
    private func countOfArrayData(_ input: String) -> Int {
        let regex = try! NSRegularExpression(pattern: "\\[", options: [])
        let list = regex.matches(in:input, options: [], range:NSRange.init(location: 0, length:input.count))
        return list.count
    }
    
    //객체 카운트
    private func countOfObjectData(_ input: String) -> Int {
        let regex = try! NSRegularExpression(pattern: "\\{", options: [])
        let list = regex.matches(in:input, options: [], range:NSRange.init(location: 0, length:input.count))
        return list.count
    }
    
    //배열 데이터 만들기
    private func makeArrayData(_ input: String) -> (array: [String], dictionary: [String:Any]) {
        var dictionary: [String:Any] = [:]
        var array: [String] = []
        let separateByCommaData = separateByComma(input)
        for data in separateByCommaData {
            if data.contains(":") {
                let dictionaryData = makeDictionaryData(data)
                let objectData = makeObjectData(dictionaryData)
                dictionary = dictionary.merging(objectData) { (current, _) in current }
            } else {
                array.append(data)
            }
        }
        let arrayData = removeDataValue(array)
        return (arrayData, dictionary)
    }
    
    
    
    /* inputValue start { */
    //:[ 중첩 배열인지 체크
    func checkColonAndBrackets(_ inputString: String) -> [String:Any] {
        // 중첩 배열인 경우
        if inputString.contains(":[") || inputString.contains(": ["){
            return makeNestedArrayData(inputString)
            //중첩 배열이 아닌 경우
        } else {
            let dictionaryData = makeDictionaryData(inputString)
            return makeObjectData(dictionaryData)
        }
    }
    
    //중첩 배열 Data
    private func makeNestedArrayData(_ arrayData: String) -> [String:Any] {
        let input = separateByColonAndBrackets(arrayData)
        let data = separateByColonOfNestedData(input)
        let seprateColonData = separateByColon(data.dictionary)
        let removeData = removeDataValue(seprateColonData)
        let dictionaryData = makeDictionary(removeData)
        let nestedKey = nestedDataKey(data.dictionary)
        let arrayData = makeNestedDictionary(nestedKey, data.array)
        let jsonData = dictionaryData.merging(arrayData) { (current, _) in current }
        return jsonData
    }
    
    // "name":"hyun" 값 만들기
    public func makeDictionaryData(_ input: String) -> [String] {
        let separateComma = separateByComma(input)
        let removeData = removeDataValue(separateComma)
        return removeData
    }
    
    // 객체 값 만들기
    private func makeObjectData(_ dictionaryData: [String]) -> [String:Any] {
        let separateColon = separateByColon(dictionaryData)
        let jsonData = makeDictionary(separateColon)
        return jsonData
    }
    
    //괄호 공백 지운 데이터 값
    private func removeDataValue(_ inputdata: [String]) -> [String] {
        let removeBracketsData = removeBrackets(inputdata)
        let removeWhiteSpaceData = removeWhiteSpace(removeBracketsData)
        return removeWhiteSpaceData
    }
    
    //:[ 기준으로 나눔
    private func separateByColonAndBrackets(_ input: String) -> [String] {
        var separateData: [String] = []
        if input.contains(":[") {
            separateData.append(contentsOf: input.components(separatedBy: ":["))
        } else if input.contains(": [") {
            separateData.append(contentsOf: input.components(separatedBy: ": ["))
        }
        return separateData
    }
    
    //:[ 기준으로 나눈 값 ,로 나눔
    private func separateByColonOfNestedData(_ input: [String]) -> (dictionary: [String],array: [String]) {
        var nestedData: [String] = []
        var dictionaryData: [String] = []
        for data in input {
            //나눈 값에서 : 이 없으면 중첩 배열 값 ,로 나눠줌
            if !data.contains(":") {
                nestedData += data.components(separatedBy: ",")
            } else {
                dictionaryData += data.components(separatedBy: ",")
            }
        }
        let removeBracketsData = removeBrackets(nestedData)
        let removeQuotationData = removeQuotation(removeBracketsData)
        let arrayData = removeWhiteSpace(removeQuotationData)
        return (dictionaryData, arrayData)
    }
    
    
    //: 기준으로 나눔
    private func separateByColon(_ input: [String]) -> [String] {
        var dictionaryData: [String] = []
        for data in input {
            if data.contains(":") {
                dictionaryData += data.components(separatedBy: ":")
            }
        }
        return dictionaryData
    }
    
    //: 없는 데이터인지 판단해서 중첩된 배열의 key 값 가져오기
    private func nestedDataKey(_ input: [String]) -> String {
        var keyData = ""
        for data in input {
            if !data.contains(":") {
                keyData += data
            }
        }
        return keyData
    }
    
    //중첩배열 dictionary 만들기
    private func makeNestedDictionary(_ arrayKey: String,_ arrayValue: [String]) -> [String:Any] {
        var arrayData: [String:Any] = [:]
        arrayData[arrayKey] = arrayValue
        return arrayData
    }
    
    //공백 지우기
    private func removeWhiteSpace(_ input: [String]) -> [String] {
        var trimmingData: [String] = []
        for data in input {
            trimmingData.append(data.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        return trimmingData
    }
    
    //콤마 기준으로 나눔
    private func separateByComma(_ input: String) -> [String] {
        let inputData = input.components(separatedBy: ",")
        return inputData
    }
    
    //괄호 지우기
    private func removeBrackets(_ input: [String]) -> [String] {
        var removeBracketsData: [String] = []
        for data in input {
            removeBracketsData.append(data.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "[", with: ""))
        }
        return removeBracketsData
    }
    
    //"" 지우기
    private func removeQuotation(_ input: [String]) -> [String] {
        var removeQuotationData: [String] = []
        for data in input {
            removeQuotationData.append(data.replacingOccurrences(of: "\"", with: ""))
        }
        return removeQuotationData
    }
    
    // 딕셔너리 반환
    private func makeDictionary(_ input: [String]) -> [String:Any] {
        var data: [String:String] = [:]
        
        for even in stride(from: 0, to: input.count-1, by: 2) {
            data[input[even]] = input[even+1]
        }
        let castingData = typecasting(data) //타입 캐스팅
        return castingData
    }
    
    // 타입 캐스팅
    private func typecasting(_ input: [String:String]) -> [String:Any] {
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
