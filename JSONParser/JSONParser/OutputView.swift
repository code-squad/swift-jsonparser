//
//  OutputView.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    private let jsonType : JSONType
    
    init(jsonType: JSONType) {
        self.jsonType = jsonType
    }
    
    func printResult() {
        var result : String = "총 \(jsonType.totalCounter)개의 \(jsonType.container) 데이터 중에"
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
        if jsonType.stringCounter > 0 {
            return " 문자열 \(jsonType.stringCounter)개,"
        }
        return ""
    }
    
    private func getIntCounter() -> String {
        if jsonType.intCounter > 0 {
            return " 숫자 \(jsonType.intCounter)개,"
        }
        return ""
    }
    
    private func getBoolCounter() -> String {
        if jsonType.boolCounter > 0 {
            return " 부울 \(jsonType.boolCounter)개,"
        }
        return ""
    }
    
    private func getObjectCounter() -> String {
        if jsonType.objectCounter > 0 {
            return " 객체 \(jsonType.objectCounter)개,"
        }
        return ""
    }
    
    private func getArrayCounter() -> String {
        if jsonType.arrayCounter > 0 {
            return " 배열 \(jsonType.arrayCounter)개,"
        }
        return ""
    }

    func printJSON(jsonPainter: JSONPainter) {
        print(jsonPainter.jsonPainting)
    }
    
}
