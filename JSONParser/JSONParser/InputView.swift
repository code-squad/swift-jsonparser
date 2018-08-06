//
//  InputView.swift
//  JSONParser
//
//  Created by 이동건 on 03/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct InputView {
    struct InputValidator {
        static func isValidFormat(target: String) -> Bool {
            var bracketsStack = target.filter {$0 == "[" || $0 == "]"}
            var rightClosedBracketsStack:[String] = []
            while bracketsStack.count != 0 {
                let item = String(bracketsStack.removeLast()) // count != 0이란 것이 증명
                if item == "]" {
                    rightClosedBracketsStack.append(item)
                }else if rightClosedBracketsStack.count != 0 {
                    rightClosedBracketsStack.removeLast()
                }
            }
            return rightClosedBracketsStack.count == 0
        }
    }
    
    static func read() -> String? {
        print("분석할 JSON 데이터를 입력하세요.")
        guard let data = readLine() else { return nil }
        return InputValidator.isValidFormat(target: data) ? data : nil
    }
}
