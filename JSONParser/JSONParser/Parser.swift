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
        // flag 를 둔 이유는? 맨처음 [ 괄호면? 배열이 들어오고 ,  { 이면 파싱해야하니깐
        var flag = 0
        data.first?.description == "[" ? (flag = 0) : (flag = 1)
        print(flag)
        // 괄호 체크
        guard isDivideData(from: data) else {
            return nil
        }
        var resultData: JSONData = JSONData()
        let dataJSON: [String] = data.removeBothFirstAndLast().splitByComma()
        resultData.datas = dataJSON // 순서 있는 사용자 input
        // [ { 일때
        var bracketData: Stack<String>
        if flag == 0 { bracketData = pushValidArray(dataJSON)}
        
        //콜론기준으로 데이터를 나누기
        let test = parseDictionary(dataJSON)
        
        
        let datasJSON: [String] = removeSpace(dataJSON)
        let parseJSONData = parseData(datasJSON)
        
        return parseJSONData
    }
    // [ { 이거 체크할때 사용
    private static func pushValidArray(_ data: [String]) -> Stack<String>{
        var bracketData: Stack<String> = Stack<String>()
        for index in 0..<data.count {
            if data[index] == "{" || data[index] == "}" {
                bracketData.push(data[index])
            }
        }
        return bracketData
    }
    
    // : 콜론을 기준으로 데이터 나눠서 JSON 요소를 저장한 사전(Dictionary) 저장 key: String : value : JSONDatas 로 받게끔
    private static func parseDictionary(_ data: [String]) ->[String:JSONData]{
        for index in 0..<data.count {
            print(data[index])
            print("----------")
        }
        let test: JSONData = JSONData()
        return ["dd": test]
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
        if ((data.first?.description) == "{"), ((data.last?.description) == "}") {
            return true
        }
        guard ((data.first?.description) == "["), ((data.last?.description) == "]") else {
            return false
        }
        
        return true
    }
    
    private static func parseData(_ data: [String]) -> JSONData?{
        var resultData: JSONData = JSONData()
        //resultData.datas = data
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
