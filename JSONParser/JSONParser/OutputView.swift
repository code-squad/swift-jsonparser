//
//  OutputView.swift
//  JSONParser
//
//  Created by 윤동민 on 02/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    // 에러의 상태를 프린트
    func printErrorState(_ errorState : FormState) {
        if errorState != .userInputForm && errorState != .fileInputForm { print(errorState.rawValue) }
    }
    
    // 각 지원하는 타입안의 데이터 타입 출력
    func printTypeCount(_ swiftData : SupportableJSON) {
        var printText : [String] = []
        let typeCount : (total : Int, string : Int, number : Int, bool : Int, object : Int, array : Int) = swiftData.matchTypeForCounting()
        
        if let text = printObjectTypeCount(typeCount.object) { printText.append(text) }
        if let text = printStringTypeCount(typeCount.string) { printText.append(text) }
        if let text = printBoolTypeCount(typeCount.bool) { printText.append(text) }
        if let text = printNumberTypeCount(typeCount.number) { printText.append(text) }
        if let text = printArrayTypeCount(typeCount.array) { printText.append(text) }
        
        for index in stride(from: 1, to: 2*printText.count-1, by: 2) { printText.insert(", ", at: index) }
        printText.insert(swiftData.createTotalText(typeCount.total), at: 0)
        printText.append("가 있습니다")
        for text in printText {
            print(text, terminator: "")
        }
        print("")
    }
    
    // 프린트할 문자열의 개수 문자열 화
    private func printStringTypeCount(_ stringCount : Int) -> String? {
        guard stringCount != 0 else { return nil }
        return "문자열 \(stringCount)개"
    }

    // 프린트할 부울의 개수 문자열 화
    private func printBoolTypeCount(_ boolCount : Int) -> String? {
        guard boolCount != 0 else { return nil }
        return "부울 \(boolCount)개"
    }
    
    // 프린트할 숫자의 개수 문자열 화
    private func printNumberTypeCount(_ numberCount : Int) -> String? {
        guard numberCount != 0 else { return nil }
        return "숫자 \(numberCount)개"
    }
    
    // 프린트할 객체의 개수 문자열 화
    private func printObjectTypeCount(_ objectCount : Int) -> String? {
        guard objectCount != 0 else { return nil }
        return "객체 \(objectCount)개"
    }
    
    // 프린트할 배열의 개수 문자열 화
    private func printArrayTypeCount(_ arrayCount : Int) -> String? {
        guard arrayCount != 0 else { return nil }
        return "배열 \(arrayCount)개"
    }
    
    func printJSONSting(_ swiftType : SupportableJSON) {
        print(swiftType.createJSONString())
    }
}
