//
//  InputView.swift
//  JSONParser
//
//  Created by yangpc on 2017. 10. 30..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    static func read() -> String? {
        print("분석할 JSON 데이터를 입력하세요.")
        let input = readLine() ?? ""
        if input == "" { return nil }
        return input
    }
}
