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
    // 입력받은 데이터를 분석해서 숫자 , 문자 , 불 로 나눠서 반환하기
    static func DivideData(from data: String) -> (([String],[String],[String]),Int)? {
        guard isDivideData(from: data) else {
            return nil
        }
        
        let dataJSON: [String] = data.removeBothFirstAndLast().splitByComma()
        let datasize = dataJSON.count
        let pushData = pushValidData(dataJSON)
        let popData = popParseData(pushData)
        
        return (popData,datasize)
    }
    // 입력받은 데이터에 괄호가 있는지 체크
    static func isDivideData(from data: String) -> Bool {
        
        guard ((data.first?.description) == "["), ((data.last?.description) == "]") else {
            return false
        }
        return true
    }
    //유효데이터를 Stack에 push
    private static func pushValidData(_ data: [String])-> Stack<String> {
        
        var stringData: Stack<String> = Stack<String>()
        
        for index in 0..<data.count {
            stringData.push(data[index])
        }
        return stringData
    }
    //data를 pop해서 숫자 , 문자 , 불 타입으로 저장
    private static func popParseData(_ data: Stack<String>) -> ([String],[String],[String]){
        var data = data
        var resultDataString:[String] = ["String"]
        var resultDataInt:[String] = ["Int"]
        var resultDataBool:[String] = ["Bool"]
        
        while !data.items.isEmpty {
            var popdata = data.pop()
            popdata = popdata.trimmingCharacters(in:.whitespacesAndNewlines)
            
            if isStringType(popdata) {
                resultDataString.append(popdata)
            }else if isBoolType(popdata) {
                resultDataBool.append(popdata)
            }else if isNumber(popdata) && isNumber(popdata) {
                resultDataInt.append(popdata)
            }
        }
        return (resultDataString,resultDataInt,resultDataBool)
    }
    
    private static func isNumber (_ popData : String) -> Bool {
        return popData.components(separatedBy: CharacterSet.decimalDigits).count != 0
    }
    private func isValidCharacter(_ popData : String) -> Bool {
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
