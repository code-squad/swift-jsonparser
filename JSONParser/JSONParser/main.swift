//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    let input = InputView.readInput(ment: "분석할 JSON 데이터를 입력하세요.")
    guard let jsonData = Parser.convert(string: input) as? JsonCollection else {return}
    OutputView.showNumberOfData(jsonData.numberByType(),type:jsonData.type())
}

main()
