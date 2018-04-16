//
//  InputView.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 16..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum Question: String {
    case askJSONData = "분석할 JSON 데이터를 입력하세요."
}

struct InputView {
    
    static func readInput(_ question: Question) -> String? {
        print(question.rawValue)
        guard let input = readLine() else {
            return nil
        }
        
        return input
    }
}
