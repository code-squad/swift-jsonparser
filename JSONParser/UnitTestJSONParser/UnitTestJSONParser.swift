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
    func testIsInputTrue() {
        let input = "[1,2,\"44\"]"
        XCTAssertTrue(CheckInput.isInputable(input: input))
    }
    
    func testIsInputFalse() {
        let input = "(1,2,\"44\")"
        XCTAssertFalse(CheckInput.isInputable(input: input))
    }
    
    
    
    func testCanSplitInput() -> [String] {
        let input = "[ 1, 2, jk, 3]"
        XCTAssertEqual(["[ 1", " 2", " jk"," 3]"], InputView.splitInput(input))
        return InputView.splitInput(input)
    }
    
    // 공백을 넣어 입력한 문자열에 대한 테스트(숫자 검색)
    func testBringNumber() {
        let splitInput = testCanSplitInput()
        XCTAssertEqual([" 1", " 2", " 3"], RegularExpression.bringData(from: splitInput, regex: "\\s[0-9]+"))
    }
    
    // 공백없이 입력한 문자열에 대한 테스트(문자 검색) -> [1,2,false,"ff"]
    func testbb() {
        let splitInput = ["[]1", "2", "false", "\"ff\""]
        XCTAssertEqual(["\"ff\""], RegularExpression.bringData(from: splitInput, regex: "\"{1}+[A-Z0-9a-z]+\"{1}"))
    }
    
    func testNotNilJSONData() {
        let input = "[ 10, 21, 4, 314, 99, 0, 72 ]"
        let splitInput = InputView.splitInput(input)
        XCTAssertNotNil(JSONData.makeJSON(from: splitInput))
    }

}
