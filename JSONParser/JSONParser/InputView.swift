//
//  InputView.swift
//  JSONParser
//
//  Created by JINA on 02/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct InputView {
    // input: [ 10, "jk", 4, "314", 99, "crong", false ] = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
    static func readInput() -> String {
        print("분석할 JSON 데이터를 입력하세요.")
        guard let input = readLine() else {
            return ""
        }
        return input
        }
    
    // splitInput: ["[ 10", " \"jk\"", " 4", " \"314\"", " 99", " \"crong\"", " false ]"]
    static func splitInput(_ input: String) -> [String] {
        let userInput = input.components(separatedBy: ",")
        return userInput
    }
}

