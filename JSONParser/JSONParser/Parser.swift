//
//  Parser.swift
//  JSONParser
//
//  Created by Elena on 20/12/2018.
//  Copyright © 2018 elena. All rights reserved.
//

import Foundation
//JSON 출력을 위한 Protocol
protocol JSONResult {
    var resultDataPrint: String { get }
    var parserResultPrint: String { get }
    
}

extension String {
    func splitByComma() -> [String] {
        return self.split(separator: ",").map({String($0)})
    }
    func removeBothFirstAndLast() -> String {
        return String(self.dropFirst().dropLast())
    }
    func splitByColon() -> [String] {
        return self.split(separator: ":").map({String($0)})
    }
}

struct Parser{
    // 입력받은 데이터를 분석해서 반환
    static func DivideData(from data: String) -> JSONData? {
        guard isDivideData(from: data) else {
            return nil
        }
        // 사용자 데이터 넣으려고
        let datasJSON = testss(data)
        //let dataJSON: [String] = data.removeBothFirstAndLast().splitByComma()
        //let datasJSON: [String] = removeSpace(dataJSON)
        //var parseJSONData = parseData(datasJSON)
        var parseJSONData = parseDatas(datasJSON)
        //사용자 입력한 그대로의 데이터를 저장하기 위해
        parseJSONData?.datas = data.splitByComma()
        return parseJSONData
    }
    // 리팩토링 해야함
    // 콤마로 나누고 , 괄호도 빼고 , 딕셔너리로 나누고 저장한 데이터 반환
    static func testss(_ data: String) -> [String:String]{
        var dicCode = [String:String]()
        // 콤마로 나누기
        var test: [String] = data.splitByComma()
        for index in 0..<test.count {
            // 괄호빼기
            if test[index].first?.description == "{" {
                //괄호를 빼고 다시 넣기
                let bracket = test[index].dropFirst()
                test[index] = String(bracket)
            }else if test[index].last?.description == "}" {
                let bracket = test[index].dropLast()
                test[index] = String(bracket)
            }
            var code = test[index].splitByColon()
            dicCode.updateValue(code[1], forKey: code[0])
        }
        return dicCode
    }
    private static func parseDatas(_ data: [String:String]) -> JSONData?{
        var resultData: JSONData = JSONData()
        for (_,value) in data {
            let value = value.trimmingCharacters(in: .whitespacesAndNewlines)
            print(value)
            
            if isStringType(value) {
                resultData.dataString.append(value)
            }else if isBoolType(value) {
                guard let isData = Bool(value) else { break }
                resultData.dataBool.append(isData)
            }else if isNumber(value) && isValidCharacter(value) {
                guard  let isData = Int(value) else{ break }
                resultData.dataInt.append(isData)
            }
        }
        return resultData
    }
    
    //데이터 사이 공백제거
    private static func removeSpace(_ data:[String]) -> [String] {
        var removeSpaceData: [String] = [String]()
        for index in 0..<data.count {
            let jsonParser = data[index].trimmingCharacters(in: .whitespacesAndNewlines)
            removeSpaceData.append(jsonParser)
        }
        return removeSpaceData
    }
    
    // 입력받은 데이터에 괄호가 있는지 체크
    static func isDivideData(from data: String) -> Bool {
        if (data.first?.description) == "{" , data.last?.description == "}" {
            return true
        }
        guard ((data.first?.description) == "["), ((data.last?.description) == "]") else {
            return false
        }
        return true
    }
    
    private static func parseData(_ data: [String]) -> JSONData?{
        var resultData: JSONData = JSONData()
        resultData.datas = data
        print(data)
        for index in 0..<data.count {
            if isStringType(data[index]) {
                resultData.dataString.append(data[index])
            }else if isBoolType(data[index]) {
                guard let isData = Bool(data[index]) else { break }
                resultData.dataBool.append(isData)
            }else if isNumber(data[index]) && isValidCharacter(data[index]) {
                guard  let isData = Int(data[index]) else{ break }
                resultData.dataInt.append(isData)
            }
        }
        return resultData
    }
    
    private static func isNumber (_ popData : String) -> Bool {
        return popData.components(separatedBy: CharacterSet.decimalDigits).count != 0
    }
    private static func isValidCharacter(_ popData : String) -> Bool {
        let validCharacter = CharacterSet.init(charactersIn: "0123456789")
        return (popData.rangeOfCharacter(from: validCharacter.inverted) == nil)
    }
    
    private static func isStringType (_ popData : String) -> Bool {
        return popData.first == "\"" && popData.last == "\""
    }
    
    private static func isBoolType (_ popData : String) -> Bool {
        return popData.contains("true") || popData.contains("false")
    }
}
