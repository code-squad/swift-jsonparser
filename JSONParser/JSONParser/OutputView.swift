//
//  OutputView.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    private var dataType: String = ""
    private var totalCount = 0
    private var stringCount = 0
    private var numberCount = 0
    private var boolCount = 0
    private var innerObjectCount = 0
    private var innerArrayCount = 0
    
    init(_ data: JSONData) {
        self.totalCount = data.count
        switch data.dataType {
        case .array:
            self.dataType = "배열"
            self.stringCount = data.arrayString.count
            self.numberCount = data.arrayNumber.count
            self.boolCount = data.arrayBool.count
        case .object:
            self.dataType = "객체"
            self.stringCount = data.objectString.count
            self.numberCount = data.objectNumber.count
            self.boolCount = data.objectBool.count
        }
        self.innerObjectCount = data.innerObjectCount
        self.innerArrayCount = data.innerArrayCount
    }
    
    func printReport() throws {
        var result = "총 \(self.totalCount)개의 \(self.dataType) 데이터 중에"
        if self.stringCount > 0 {
            result += " 문자열 \(self.stringCount)개,"
        }
        if self.numberCount > 0 {
            result += " 숫자 \(self.numberCount)개,"
        }
        if self.boolCount > 0 {
            result += " 부울 \(self.boolCount)개,"
        }
        if self.innerObjectCount > 0 {
            result += " 객체 \(self.innerObjectCount)개,"
        }
        if self.innerArrayCount > 0 {
            result += " 배열 \(self.innerArrayCount)개,"
        }
        result.removeLast()             // 마지막 콤마(,) 제거.
        result += "가 포함되어 있습니다."
        print(result)
    }
    
    static func printError(_ error: GrammarChecker.JsonError) {
        print(error.rawValue)
    }
    
}
