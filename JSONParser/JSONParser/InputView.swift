//
//  InputView.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 19..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    private let validCharactersInArray = CharacterSet.init(charactersIn: " ,[]truefalse\"").union(CharacterSet.alphanumerics)
    
    func readInput() -> String {
        print("분석할 JSON데이터를 입력하세요. 종료를 원하시면 q를 입력해주세요.")
        let userJson = readLine()
        guard let input = userJson else {
            return ""
        }
        return input
    }
    
    private func isArray (_ userInput : String) -> Bool {
        if userInput.first == "[" && userInput.last == "]" {
            return true
        }
        print("배열의 형태가 아닙니다. 다시 입력해주세요.")
        return false
    }
    
    func isValid (_ userInput : String) -> Bool {
        guard isArray(userInput) == true else { return false }
        let userCharacters = userInput.components(separatedBy: validCharactersInArray).filter { $0 != "" }
        if userCharacters.count == 0 {
            return true
        }
        print("지원하지 않는 규격이 들어 있습니다. 다시 입력해주세요.")
        return false
    }
    
    func sliceMarks (_ userInput : String) -> String {
        let userInputWithoutEmpty = sliceOneMark(userInput, mark: " ")
        let userInputWithoutLeftMark = sliceOneMark(userInputWithoutEmpty, mark: "[")
        return sliceOneMark(userInputWithoutLeftMark, mark: "]")
    }
    
    private func sliceOneMark (_ fullString : String, mark : Character) -> String {
        var temp = ""
        let stringsWithoutMark : [String] = fullString.split(separator: mark).map(String.init)
        for index in 0..<stringsWithoutMark.count {
            temp += stringsWithoutMark[index]
        }
        return temp
    }
}

