//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    let checkInput : CheckInput = CheckInput()
    var input : String
    var extractData : [String]
    repeat {
        input = InputView.UserInput(message: "분석할 JSON 문자열을 입력하세요.")
        extractData = input.components(separatedBy: ["[", ",", "]"])
    } while !checkInput.IsArrayType(input) || !checkInput.IsSupportType(extractData)
}


main()
