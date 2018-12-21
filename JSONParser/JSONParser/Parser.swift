//
//  Parser.swift
//  JSONParser
//
//  Created by Elena on 20/12/2018.
//  Copyright © 2018 elena. All rights reserved.
//

import Foundation
//분석
//
protocol resultProtocol {
    var resultString: String { get }
    var resultNumber: Int { get }
}

extension String {
    func splitByComma() -> [String] {
        return self.split(separator: ",").map({String($0)})
    }
    func removeBothFirstAndLast() -> String {
        return String(self.dropFirst().dropLast())
    }
}
// 비교를 하기 위해 Equatable 프로토콜 사용
struct Parser : Equatable {
    
    static func DivideData(from data: String) ->[String:Int]? {
        guard isDivideData(from: data) else {
            return nil
        }
        let dataJSON: [String] = data.removeBothFirstAndLast().splitByComma()
        
        let pushData = pushValidData(dataJSON)
        let popData = popParseData(pushData)

        return popData
        
    }
    
    static func isDivideData(from data: String) -> Bool {
        
        guard ((data.first?.description) == "["), ((data.last?.description) == "]") else {
            return false
        }
        return true
    }
    
    private static func pushValidData(_ data: [String])-> Stack<String> {
        
        var stringData: Stack<String> = Stack<String>()
        
        for index in 0..<data.count {
            stringData.push(data[index])
        }
        return stringData
    }
    
    private static func popParseData(_ data: Stack<String>) -> [String:Int]{
        var data = data
        var number = [0,0,0]
        var resultData: [String:Int] = ["String":0,"Int":0,"Bool":0]
        
        while !data.items.isEmpty {
            var popdata = data.pop()
            popdata = popdata.trimmingCharacters(in:.whitespacesAndNewlines)
            if isStringType(popdata) {
                number[1] += 1
            }else if isBoolType(popdata) {
                number[2] += 1
            }else if isNumber(popdata) {
                number[0] += 1
            }
        }
        resultData["String"] = number[1]
        resultData["Int"] = number[0]
        resultData["Bool"] = number[2]
        
        return resultData
    }
    
    private static func isNumber (_ popData : String) -> Bool {
        return popData.components(separatedBy: CharacterSet.decimalDigits).count != 0
    }
    
    private static func isStringType (_ popData : String) -> Bool {
        return popData.first == "\"" && popData.last == "\""
    }
    
    private static func isBoolType (_ popData : String) -> Bool {
        return popData.contains("true") || popData.contains("false")
    }
}
