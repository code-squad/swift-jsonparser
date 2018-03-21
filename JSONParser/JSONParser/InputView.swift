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
    
    func checkBrackets(_ input: String) -> (bool: Bool,value: [String]) {
        if input.hasPrefix("{") {
            let data = separateByComma(input)
            let inputData = separateByColon(data)
            let removeBracketsData = removeBrackets(inputData)
            let removeWhiteSpaceData = removeWhiteSpace(removeBracketsData)
            return (true, removeWhiteSpaceData)
        } else if input.hasPrefix("[") {
            let data = separateByBrackets(input)
            return (false, data)
        } else {
            return (false, [])
        }
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
    
    func removeBrackets(_ input: [String]) -> [String] {
        var removeBracketsData:[String] = []
        for data in input {
            removeBracketsData.append(data.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "\"", with: ""))
        }
        return removeBracketsData
    }
    
    func removeWhiteSpace(_ inputData: [String]) -> [String] {
        var data:[String] = []
        for index in 0..<inputData.count {
            data.append(inputData[index].trimmingCharacters(in: .whitespacesAndNewlines))
        }
        return data
    }
    
    func separateByBrackets(_ input: String) -> [String] {
        let inputData = input.components(separatedBy: "},")
        return inputData
    }

}

