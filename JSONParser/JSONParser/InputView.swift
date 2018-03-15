//
//  InputView.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 12..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    func readInput(_ message: String) -> String {
        print(message)
        let input = readLine()
        guard let inputData = input else { return "" }
        return inputData
    }
    
    func separateByComma(_ input: String) -> [String] {
        let inputData = input.components(separatedBy: ",")
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
    
    func makeDataArray(_ inputData: [String]) -> (number: [Int], string: [String], bool: [Bool]) {
        var numberData: [Int] = []
        var stringData: [String] = []
        var boolData: [Bool] = []
        
        for data in inputData {
            if data.contains("\"") {
                stringData.append(data)
            } else if let boolInput = Bool.init(data) {
                boolData.append(boolInput)
            } else if let numberInput = Int.init(data) {
                numberData.append(numberInput)
            } else {
                print("정확한 데이터 값으로 다시 입력하세요")
                break
            }
        }
        return (numberData, stringData, boolData)
    }
    
}

