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
    
    func makeDataArray(_ input: String) -> [String]{
        let data = input.components(separatedBy: ", ")
        var dataArray: [String] = []
        dataArray.append(String(data[0].dropFirst()))
        let last = data.count-1
        for index in 1..<last {
            dataArray.append(data[index])
        }
        dataArray.append(String(data[last].dropLast()))
        return dataArray
    }
    
    func countData(_ dataArray: Array<String>) -> (number: Int, string: Int, bool: Int){
        var numberCount = 0
        var stringCount = 0
        var boolCount = 0
        
        for data in dataArray {
            if data.contains("\"") {
                stringCount += 1
            } else if data == "true" || data == "false" {
                boolCount += 1
            } else {
                numberCount += 1
            }
        }
        return (numberCount, stringCount, boolCount)
    }
    
    
    
}

