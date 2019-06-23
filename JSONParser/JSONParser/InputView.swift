//
//  InputView.swift
//  JSONParser
//
//  Created by BLU on 2019. 5. 28..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    enum Question: String {
        case enterJSONData = "분석할 JSON 데이터를 입력하세요."
    }
    
    private static func readText(ask question: Question) -> String {
        print(question.rawValue)
        return readLine() ?? ""
    }
    
    static func readJSONData() -> String {
        return readText(ask: .enterJSONData)
    }
}
