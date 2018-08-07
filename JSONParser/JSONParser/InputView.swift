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
            return checkBracketsPair(target)
        }
        
        static func checkBracketsPair(_ target: String) -> Bool {
            let onlyData = target.filter {$0 != Character("{") && $0 != Character("}") && $0 != Character("[") && $0 != Character("]")}
            let brackets = target.filter { !onlyData.contains($0)}
            var bracketStack: [Character] = []
            for bracket in brackets {
                if bracket == Character("{") || bracket == Character("[") {
                    bracketStack.append(bracket)
                }else {
                    if bracketStack.isEmpty {
                        return false
                    }
                    let top = bracketStack.last
                    if (top == "{" && bracket == "}") || (top == "[" && bracket == "]") {
                        bracketStack.removeLast()
                    }
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
