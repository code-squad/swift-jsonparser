//
//  main.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 11..
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

while true {
    var validString: String = ""
    do {
        // 문법체크
        let unanalyzedValue = try InputView.read(ProcessInfo.processInfo.arguments)
        if unanalyzedValue == Message.ofEndingProgram.description { break }
        validString += try GrammerChecker.makeValidString(values: unanalyzedValue)
        // 분석된 Json 타입인스턴스 생성
        let analyzedValue = Analyzer.makeAnalyzedTypeInstance(validString)
        // JsonDataType 출력
        try OutputView.printOut(analyzedValue, ProcessInfo.processInfo.arguments)
    } catch Message.ofEndingProgram {
        break
    } catch Message.ofFailedProcessingFile {
        print (Message.ofFailedProcessingFile.description)
        break
    } catch let error as Message {
        print (error.description)
    }
}

