//
//  main.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 11..
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

while true {
    let unanalyzedValue = InputView.read()
    if unanalyzedValue == InputView.FrontMessage.ofEndingProgram.description { break }
    var validString: String = ""
    do {
        // 문법체크
        validString += try GrammerChecker.makeValidString(values: unanalyzedValue)
    } catch let error as GrammerChecker.ErrorOfJasonGrammer {
        print (error.localizedDescription)
        continue
    }
    // 분석된 Json 타입인스턴스 생성
    let analyzedValue = Analyzer.makeAnalyzedTypeInstance(validString)
    // Json타입 카운팅
    let countedValue =  CountingJsonData.makeCountedTypeInstance(jsonType: analyzedValue)
    // 카운팅 출력
    OutputView.printCountedResult(countedValue)
    // JsonDataType 출력
    OutputView.printJsonDataType(analyzedValue)
}
