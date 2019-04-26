//
//  InputView.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/26/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct InputView {
    private(set) var valueEntered: String = ""
    
    mutating func readInput () {
        print("분석할 JSON 데이터를 입력하세요.")
        valueEntered = readLine() ?? "0"
    }
}

