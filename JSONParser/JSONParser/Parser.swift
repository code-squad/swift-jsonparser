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
        if data.first?.description == "[" {
            var bracket = JSONData()
            bracket.dataString = ["ObjectData":data]
            return bracket
        }
        let dataJSON = parserForm(data)
        let parseJSONData = parseData(dataJSON)
        return parseJSONData
    }
    static func parseBracket(_ data: String) -> ObjectData? {
        var resultData: ObjectData = ObjectData()
        var leftBracket = 0
        var rightBracket = 0
        leftBracket = data.components(separatedBy: "{").count
        rightBracket = data.components(separatedBy: "}").count
        if leftBracket != rightBracket {
            return nil
        }
        resultData.objectCount = leftBracket-1
        return resultData
    }
    // Form 만들기
    private static func parserForm(_ data: String) -> [String:String]{
        var dicFormData = [String:String]()
        var dataSplitByComma: [String] = data.splitByComma()
        for index in 0..<dataSplitByComma.count {
            
            if dataSplitByComma[index].first?.description == "{" {
                let bracket = dataSplitByComma[index].dropFirst()
                dataSplitByComma[index] = String(bracket)
                
            }else if dataSplitByComma[index].last?.description == "}" {
                let bracket = dataSplitByComma[index].dropLast()
                dataSplitByComma[index] = String(bracket)
            }
            var dataSplitByColon = dataSplitByComma[index].splitByColon()
            dicFormData.updateValue(dataSplitByColon[1], forKey: dataSplitByColon[0])
        }
        return dicFormData
    }
    
    private static func parseData(_ data: [String:String]) -> JSONData?{
        var resultData: JSONData = JSONData()
        for (key,value) in data {
            let value = value.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if isStringType(value) {
                resultData.dataString.updateValue(value, forKey: key)
            }else if isBoolType(value) {
                guard let isData = Bool(value) else { break }
                resultData.dataBool.updateValue(isData, forKey: key)
            }else if isNumber(value) && isValidCharacter(value) {
                guard  let isData = Int(value) else{ break }
                resultData.dataInt.updateValue(isData, forKey: key)
            }
        }
        return resultData
    }
    
    // 괄호가 있는지 체크
    static func isDivideData(from data: String) -> Bool {
        if (data.first?.description) == "{" , data.last?.description == "}" {
            return true
        }
        guard ((data.first?.description) == "["), ((data.last?.description) == "]") else {
            return false
        }
        return true
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
