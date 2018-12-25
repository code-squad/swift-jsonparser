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
}

struct Parser{
    // 입력받은 데이터를 분석해서 반환
    static func DivideData(from data: String) -> JSONData? {
        guard isDivideData(from: data) else {
            return nil
        }
        
        let dataJSON: [String] = data.removeBothFirstAndLast().splitByComma()
        let datasJSON: [String] = removeSpace(dataJSON)
        let parseJSONData = parseData(datasJSON)
        
        return parseJSONData
    }
    //공백제거
    static func removeSpace(_ data:[String]) -> [String] {
        var removeSpaceData: [String] = [String]()
        for index in 0..<data.count {
            let jsonParser = data[index].trimmingCharacters(in: .whitespacesAndNewlines)
            removeSpaceData.append(jsonParser)
        }
        return removeSpaceData
    }
    
    // 입력받은 데이터에 괄호가 있는지 체크
    static func isDivideData(from data: String) -> Bool {
        
        guard ((data.first?.description) == "["), ((data.last?.description) == "]") else {
            return false
        }
        return true
    }
    
    static func parseData(_ data: [String]) -> JSONData?{
        var resultData: JSONData = JSONData()
        resultData.datas = data
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
