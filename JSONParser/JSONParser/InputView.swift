//
//  InputView.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 12..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    func readInput(_ message: String) {
        print(message)
        let input = readLine()
        guard let inputData = input else { return }
        checkBrackets(inputData)
    }
    
    func checkBrackets(_ input: String) {
        if input.hasPrefix("{") {
            let data = separateByComma(input)
            let inputData = separateByColon(data)
            let dropBracktsData = dropBrackets(inputData)
            let removeWhiteSpaceData = removeWhiteSpace(dropBracktsData)
            makeDictionary(removeWhiteSpaceData)
        }
        if input.hasPrefix("[") {
            let data = separateByBrackets(input)
            makeDataArray(data)
        }
    }
    
    func separateByBrackets(_ input: String) -> [String] {
        let inputData = input.components(separatedBy: "},")
        return inputData
    }
    
    func separateByComma(_ input: String) -> [String] {
        let inputData = input.components(separatedBy: ",")
        return inputData
    }
    
    func separateByColon(_ input: [String]) -> [String] {
        var inputData: [String] = []
        for data in input {
            inputData += data.components(separatedBy: ":")
        }
        return inputData
    }
    
    func dropBrackets(_ inputData: [String]) -> [String] {
        var data: [String] = []
        data.append(String(inputData[0].dropFirst()))
        let last = inputData.count-1
        for index in 1..<last {
            data.append(inputData[index])
        }
        data.append(String(inputData[last].dropLast()))
        return data
    }
    
    func removeWhiteSpace(_ inputData: [String]) -> [String] {
        var data: [String] = []
        for index in 0..<inputData.count {
            data.append(inputData[index].trimmingCharacters(in: .whitespacesAndNewlines))
        }
        return data
    }

    func makeDictionary(_ input: [String]) {
        var numberData: [String:Int] = [:]
        var stringData: [String:String] = [:]
        var boolData: [String:Bool] = [:]
        
        for index in 0..<input.count {
            if index % 2 == 1 {
                if input[index].contains("\"") {
                    stringData[input[index-1]] = input[index]
                } else if let boolInput = Bool.init(input[index]) {
                    boolData[input[index-1]] = boolInput
                } else if let numberInput = Int.init(input[index]) {
                    numberData[input[index-1]] = numberInput
                }  else {
                    print("정확한 데이터 값으로 다시 입력하세요")
                    break
                }
            }
            if index % 2 == 0 {
                if !input[index].contains("\"") {
                    print("정확한 데이터 값으로 다시 입력하세요")
                    break
                }
            }
        }
        ResultView().resultDicionaryMessage(numberData, stringData, boolData)
    }
    
    func makeDataArray(_ input: [String]) {
        var removeBracketsData = ""
        
        for data in input {
            removeBracketsData = data.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        }
        let separateCommaData = separateByComma(removeBracketsData)
        let separateColonData = separateByColon(separateCommaData)
        let vaildInput = GrammarChecker().isValidInput(separateColonData)
        
        if vaildInput {
            ResultView().resultArrayMessage(input)
        } else {
            print("정확한 데이터 값으로 다시 입력하세요")
        }
    }
    
}
