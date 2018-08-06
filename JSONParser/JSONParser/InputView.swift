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
        private var elements: [String] = []
        
        var result: [String]? {
            return elements.count == 0 ? nil : elements
        }
        
        init?(input: String) {
            if !isValidFormat(target: input) { return nil }
            self.elements = parse(from: input)
        }
        
        func isValidFormat(target: String) -> Bool {
            var brackets = target.filter {$0 == "[" || $0 == "]"}
            var rightClosedBrackets:[String] = []
            while brackets.count != 0 {
                let item = String(brackets.removeLast()) // count != 0이란 것이 증명
                if item == "]" {
                    rightClosedBrackets.append(item)
                }else if rightClosedBrackets.count != 0 {
                    rightClosedBrackets.removeLast()
                }
            }
            return rightClosedBrackets.count == 0
        }
        
        func parse(from target: String) -> [String] {
            var rawValue = target
            rawValue = rawValue.replacingOccurrences(of: " ", with: "")
            rawValue = rawValue.replacingOccurrences(of: "]", with: "")
            rawValue = rawValue.replacingOccurrences(of: "[", with: "")
            return rawValue.split(separator: ",").map {String($0)}
        }
    }
    
    static func read() -> [String]? {
        print("분석할 JSON 데이터를 입력하세요.")
        guard let data = readLine() else { return nil }
        guard let result = InputValidator(input: data)?.result else { return nil }
        return result
    }
}
