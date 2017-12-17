//
//  InputView.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 4..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    func askUserInput () -> String? {
        print("분석할 JSON 데이터를 입력하세요.")
        let userInput = readLine()
        return userInput
    }
}

