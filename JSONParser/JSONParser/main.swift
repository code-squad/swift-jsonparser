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
    
    guard GrammarChecker.checkInputData(data:input) else {print("지원하지 않는 형식을 포함하고 있습니다.");return}
    guard let jsonData = Parser.convert(string: input) else {return}
    
    guard let collectionTypeJsonData = jsonData as? JsonCollection else {return}
    OutputView.showNumberOfData(collectionTypeJsonData.numberByType(),type:collectionTypeJsonData.type())
    OutputView.showJsonForm(collectionTypeJsonData)
}

main()
