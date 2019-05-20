//
//  InputView.swift
//  JSONParser
//
//  Created by 이진영 on 20/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct InputView {
    static private let question = "분석할 JSON 데이터를 입력하세요."
    
    static func readInput() -> String {
        print(question)
        
        return readLine() ?? ""
    }
}
