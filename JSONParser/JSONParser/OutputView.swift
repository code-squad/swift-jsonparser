//
//  OutputView.swift
//  JSONParser
//
//  Created by hw on 09/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static private let unit = "개"
    static func printJsonInformation (_ parsingResult: JsonFormatter ){
        print("총 \(parsingResult.totalCount)개의 데이터 중에",terminator :"")
        print("\(LexicalType.string.description) \(parsingResult.stringCount)\(unit)",terminator :", ")
        print("\(LexicalType.intNumber.description) \(parsingResult.intCount)\(unit)",terminator :", ")
        print("\(LexicalType.bool.description) \(parsingResult.boolCount)\(unit)",terminator :"")
        print("가 포함되어 있습니다.")
    }
}
