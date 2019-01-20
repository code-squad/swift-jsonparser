//
//  UnitTestJSONParser.swift
//  UnitTestJSONParser
//
//  Created by JINA on 02/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest
@testable import JSONParser

class UnitTestJSONParser: XCTestCase {
    func testIsNotNilJsonData() {
        let input = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let splited = InputView.splitInput(input)
        let data = RegularExpression.makeJsonData(split: splited)
        XCTAssertNotNil(data)
    }
    
    func testJsonDataCount() {
        let input = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let splited = InputView.splitInput(input)
        let data = RegularExpression.makeJsonData(split: splited)
        let out = OutputView.countData(in: data, from: splited)
        XCTAssertEqual(["문자열" : 3, "숫자" : 3, "부울" : 1, ], out)
    }
    
    func testOneJsonData() {
        let input = "[ \"jk\", \"314\", \"crong\" ]"
        let splited = InputView.splitInput(input)
        let data = RegularExpression.makeJsonData(split: splited)
        let out = OutputView.countData(in: data, from: splited)
        XCTAssertEqual(["문자열" : 3, "숫자" : 0, "부울" : 0, ], out)
    }
}
