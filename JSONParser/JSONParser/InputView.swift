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
    
    func makeDataArray(_ input: String) -> Array<Any> {
        let data = input.components(separatedBy: ", ")
        var dataArray: [Any] = []
        dataArray.append(data[0].dropFirst())
        let last = data.count-1
        for index in 1..<last {
            dataArray.append(data[index])
        }
        dataArray.append(data[last].dropLast())
        return dataArray
    }

}
