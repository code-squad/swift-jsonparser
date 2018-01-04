//
//  InputView.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
     enum FrontMessage {
        case ofWelcoming
        case ofEndingProgram
        var description: String {
            switch self {
            case .ofWelcoming :
                return "분석할 JSON 데이터를 입력하세요. quit입력시 종료됩니다"
            case .ofEndingProgram :
                return "quit"
            }
        }
    }
    
    static func read() -> String {
        print (FrontMessage.ofWelcoming.description)
        if let unanalyzedValue = readLine() {
            guard unanalyzedValue == FrontMessage.ofEndingProgram.description else { return unanalyzedValue }
        }
        return FrontMessage.ofEndingProgram.description
    }
}
