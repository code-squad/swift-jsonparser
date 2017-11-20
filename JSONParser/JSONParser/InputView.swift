//
//  InputView.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    func readInput() -> String{
        print("분석할 JSON 데이터를 입력하세요.")
        if let jsonValue = readLine() {
            return jsonValue
        }
        return ""
    }
}
