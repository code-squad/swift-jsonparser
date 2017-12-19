//
//  InputView.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 19..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    func readInput() -> String {
        print("분석할 JSON데이터를 입력하세요. 종료를 원하시면 q를 입력해주세요.")
        let userJson = readLine()
        guard let input = userJson else {
            return ""
        }
        return input
    }
    
}

