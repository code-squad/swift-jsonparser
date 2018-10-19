//
//  UnitTestExtensions.swift
//  JSONParserUnitTest
//
//  Created by 윤지영 on 19/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest

class UnitTestExtensions: XCTestCase {
    let jsonString = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
    let noWhiteSpace = "[10,\"jk\",4,\"314\",99,\"crong\",false]"
    let noSideSquareBracket = "10, \"jk\", 4, \"314\", 99, \"crong\""
    let oneSideSquareBracket = "[10, \"jk\", 4, \"314\", 99, \"crong\""
    let trimmedSquareBrackets = " 10, \"jk\", 4, \"314\", 99, \"crong\", false "
    let stringSurroundedDoubleQuotation = "\"jamie\""
    let trimmedDoubleQuotation = "jamie"
    let splitArray = ["[ 10", " \"jk\"", " 4", " \"314\"", " 99", " \"crong\"", " false ]"]
    
    override func setUp() {}
    override func tearDown() {}

    func testRemoveWhiteSpaces() {
        XCTAssertEqual(jsonString.removeWhiteSpaces(), noWhiteSpace)
    }
    
    func testHasNoSideSquareBracket() {
        XCTAssertFalse(noSideSquareBracket.hasSideSquareBrackets())
    }
    
    func testHasOneSideSquartBracket() {
        XCTAssertFalse(oneSideSquareBracket.hasSideSquareBrackets())
    }
    
    func testHasSideSquareBrackets() {
        XCTAssertTrue(jsonString.hasSideSquareBrackets())
    }
    
    func testTrimSquareBrackets() {
        XCTAssertEqual(jsonString.trimSquareBrackets(), trimmedSquareBrackets)
    }
    
    func testTrimDoubleQuotation() {
        XCTAssertEqual(stringSurroundedDoubleQuotation.trimDoubleQuotation(), trimmedDoubleQuotation)
    }
    
    func testSplitByComma() {
        XCTAssertEqual(jsonString.splitByComma(), splitArray)
    }
    
}
