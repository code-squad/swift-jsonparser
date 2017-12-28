//
//  InputView.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    static func read() -> String {
        print ("분석할 JSON 데이터를 입력하세요. quit입력시 종료됩니다")
        if let unanalyzedValue = readLine() {
            guard unanalyzedValue == "quit" else { return unanalyzedValue }
        }
        return "quit"
    }
}
