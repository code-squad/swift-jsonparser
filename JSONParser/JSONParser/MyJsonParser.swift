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
            let removeWhiteSpaceData = removeWhiteSpace(input)
            let jsonData = checkColonAndBrackets(removeWhiteSpaceData)
            return jsonData
        } else if input.hasPrefix("[") {
            let removeWhiteSpaceData = removeWhiteSpace(input)
            let dropBracketsData = dropBrackets(removeWhiteSpaceData)
            let arrayCount = countOfArrayData(dropBracketsData)
            let objectCount = countOfObjectData(dropBracketsData)
            let jsonData = ArrayData.init(array: arrayCount, object: objectCount)
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
    
    /* inputValue start { */
    //:[ 중첩 배열인지 체크
    func checkColonAndBrackets(_ inputString: String) -> [String:Any]? {
        // 중첩 배열인 경우
        if inputString.contains(":[") {
            return makeNestedArrayData(inputString)
            //중첩 배열이 아닌 경우
        } else {
            return makeObjectData(inputString)
        }
    }
    
    //중첩 배열 Data
    private func makeNestedArrayData(_ arrayData: String) -> [String:Any] {
        let data = separateByColonAndBrackets(arrayData)
        let seprateColonData = containOfColon(data.dictionary)
        let removeBracketsData = removeBrackets(seprateColonData)
        let dictionaryData = makeDictionary(removeBracketsData)
        let nestedKey = nestedDataKey(data.dictionary)
        let arrayData = makeNestedDictionary(nestedKey, data.array)
        let jsonData = dictionaryData.merging(arrayData) { (current, _) in current }
        return jsonData
    }
    
    //객체 Data
    private func makeObjectData(_ objectData: String) -> [String:Any]? {
        let grammarChecker = GrammarChecker()
        let separateComma = separateByComma(objectData)
        let removeBracketsData = removeBrackets(separateComma)
        guard grammarChecker.isValidFirstQuotation(removeBracketsData) else {
            print("지원하지 않는 형식을 포함하고 있습니다.")
            return nil }
        let removeQuotationData = removeQuotation(removeBracketsData)
        let separateColon = separateByColon(removeQuotationData)
        let jsonData = makeDictionary(separateColon)
        guard grammarChecker.isValidDictionaryKey(data: jsonData) else {
            print("지원하지 않는 형식을 포함하고 있습니다.")
            return nil }
        return jsonData
    }
    
    //:[ 기준으로 나눔
    private func separateByColonAndBrackets(_ input: String) -> (dictionary: [String],array: [String]) {
        var nestedData: [String] = []
        var dictionaryData: [String] = []
        //input :[ 으로 나누고
        let separateData = input.components(separatedBy: ":[")
        for data in separateData {
            //나눈 값에서 : 이 없으면 중첩 배열 값 ,로 나눠줌
            if !data.contains(":") {
                nestedData += data.components(separatedBy: ",")
            } else {
                dictionaryData += data.components(separatedBy: ",")
            }
        }
        let arrayData = removeBrackets(nestedData)
        return (dictionaryData, arrayData)
    }
    
    //: 있는 데이터만 값 가져오기
    private func containOfColon(_ input: [String]) -> [String]{
        var dictionaryData: [String] = []
        for data in input {
            if data.contains(":"){
                dictionaryData += data.components(separatedBy: ":")
            }
        }
        return dictionaryData
    }
    
    //: 없는 데이터인지 판단해서 중첩된 배열의 key 값 가져오기
    private func nestedDataKey(_ input: [String]) -> String {
        var tempData = ""
        for data in input {
            if !data.contains(":") {
                tempData += data
            }
        }
        let nestedKey = tempData.replacingOccurrences(of: "\"", with: "")
        return nestedKey
    }
    
    //중첩배열 dictionary 만들기
    private func makeNestedDictionary(_ arrayKey: String,_ arrayValue: [String]) -> [String:Any] {
        var arrayData: [String:Any] = [:]
        arrayData[arrayKey] = arrayValue
        return arrayData
    }
    
    //콜론 기준으로 나눔
    private func separateByColon(_ input: [String]) -> [String] {
        var inputData: [String] = []
        for data in input {
            inputData += data.components(separatedBy: ":")
        }
        return inputData
    }
    
    //공백 지우기
    private func removeWhiteSpace(_ inputData: String) -> String {
        let removeWhiteSpaceData = inputData.replacingOccurrences(of: " ", with: "")
        return removeWhiteSpaceData
    }
    
    //콤마 기준으로 나눔
    private func separateByComma(_ input: String) -> [String] {
        let inputData = input.components(separatedBy: ",")
        return inputData
    }
    
    //괄호 지우기
    private func removeBrackets(_ input: [String]) -> [String] {
        var removeBracketsData:[String] = []
        for data in input {
            removeBracketsData.append(data.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "[", with: ""))
        }
        return removeBracketsData
    }
    
    //따옴표 지우기
    private func removeQuotation(_ input: [String]) -> [String] {
        var removeQuotationData:[String] = []
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
