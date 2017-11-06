//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

typealias JsonData = Array<Any>

print("분석할 JSON 데이터를 입력하세요.")
let inputView = InputView()
let tester = inputView.readInput()
for item in tester {
    print(item, type(of: item))
}

