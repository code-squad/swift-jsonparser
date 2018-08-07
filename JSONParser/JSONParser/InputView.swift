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
            let onlyData = target.filter {$0 != Character(left) && $0 != Character(right)}
            if onlyData.count == 0 { // 데이터가 없으면 틀린 형식
                return false
            }
            
            let brackets = target.filter {$0 == Character(left) || $0 == Character(right)}
            if brackets.count == 0 { // 괄호가 없어도 틀린 형식
                return false
            }
            
            var bracketStack: [Character] = []
            for bracket in brackets {
                if bracket == Character(left){
                    bracketStack.append(bracket)
                }else {
                    if bracketStack.isEmpty {
                        return false
                    }
                    bracketStack.removeLast()
                }
            }
            
            return bracketStack.count == 0
        }
    }
    
    static func read() -> String? {
        print("분석할 JSON 데이터를 입력하세요.")
        guard let data = readLine() else { return nil }
        return InputValidator.isValidFormat(target: data) ? data : nil
    }
}
