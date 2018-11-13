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
    func printErrorState(_ errorState : InputState) {
        if errorState != .rightInput { print(errorState.rawValue) }
    }
    
    // 화면에 타입의 개수를 출력
    func printType(typeCount : (total : Int, string : Int, bool : Int, number : Int)) {
        var printText : [String] = []
        if let text = printStringTypeCount(typeCount.string) { printText.append(text) }
        if let text = printBoolTypeCount(typeCount.bool) { printText.append(text) }
        if let text = printNumberTypeCount(typeCount.number) { printText.append(text) }
        for index in stride(from: 1, to: 2*printText.count-1, by: 2) {
            printText.insert(", ", at: index)
        }
        printText.insert("총 \(typeCount.total)의 데이터 중에 ", at: 0)
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
}
