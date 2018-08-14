//
//  InputView.swift
//  JSONParser
//
//  Created by 이동건 on 03/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    static func read() throws -> String {
        print("분석할 JSON 데이터를 입력하세요.")
        guard let data = readLine() else {
            throw JSONParserError.invalidInput
        }
        
        return data
    }
}
