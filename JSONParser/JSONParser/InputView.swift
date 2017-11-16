//
//  InputView.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    // 사용자 입력값의 json 규격 체크 후 반환.
    static func askFor(message: String) throws -> String? {
        // 요구 메시지 출력.
        print("\(message)", terminator: " ")
        // q 또는 quit 입력 시 종료.
        guard let inputLine = readLine(), inputLine != "q" && inputLine != "quit" else { return nil }
        return inputLine
    }
    
}
