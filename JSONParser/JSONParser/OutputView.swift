//
//  OutputView.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    private let typeCounter : TypeCounter
    
    init(typeCounter: TypeCounter) {
        self.typeCounter = typeCounter
    }
    
    func printResult() {
        var result : String = "총 \(typeCounter.totalCounter)개의 \(typeCounter.container) 데이터 중에"
        result += getObjectCounter()
        result += getStringCounter()
        result += getIntCounter()
        result += getBoolCounter()
        result += getArrayCounter()
        result.removeLast()
        result += "가 포함되어 있습니다."
        print(result)
    }
    
    private func getStringCounter() -> String {
        if typeCounter.stringCounter > 0 {
            return " 문자열 \(typeCounter.stringCounter)개,"
        }
        return ""
    }
    
    private func getIntCounter() -> String {
        if typeCounter.intCounter > 0 {
            return " 숫자 \(typeCounter.intCounter)개,"
        }
        return ""
    }
    
    private func getBoolCounter() -> String {
        if typeCounter.boolCounter > 0 {
            return " 부울 \(typeCounter.boolCounter)개,"
        }
        return ""
    }
    
    private func getObjectCounter() -> String {
        if typeCounter.objectCounter > 0 {
            return " 객체 \(typeCounter.objectCounter)개,"
        }
        return ""
    }
    
    private func getArrayCounter() -> String {
        if typeCounter.arrayCounter > 0 {
            return " 배열 \(typeCounter.arrayCounter)개,"
        }
        return ""
    }

    func printJSON(jsonPainter: JSONPainter) {        
        print(jsonPainter)
        print(jsonPainter.jsonPainting)
    }
    
}
