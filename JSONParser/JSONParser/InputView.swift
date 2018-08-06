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
            return checkBracketsPair(target, left: "[", right: "]") && checkBracketsPair(target, left: "{", right: "}")
        }
        
        static func checkBracketsPair(_ target: String, left: String, right: String) -> Bool {
            var leftBracketsStack = target.filter {$0 == Character(left) || $0 == Character(right)}
            var rightBracketStack:[String] = []
            
            while leftBracketsStack.count != 0 {
                let item = String(leftBracketsStack.removeLast()) // count != 0이란 것이 증명
                if item == right {
                    rightBracketStack.append(item)
                }else if rightBracketStack.count != 0 {
                    rightBracketStack.removeLast()
                }
            }
            
            return rightBracketStack.count == 0
        }
    }
    
    static func read() -> String? {
        print("분석할 JSON 데이터를 입력하세요.")
        guard let data = readLine() else { return nil }
        return InputValidator.isValidFormat(target: data) ? data : nil
    }
}
