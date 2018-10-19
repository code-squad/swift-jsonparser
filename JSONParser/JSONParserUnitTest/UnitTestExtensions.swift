//
//  UnitTestExtensions.swift
//  JSONParserUnitTest
//
//  Created by 윤지영 on 19/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest

class UnitTestExtensions: XCTestCase {
    override func setUp() {}
    override func tearDown() {}

    func testRemoveWhiteSpaces() {
        let jsonString = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let noWhiteSpace = "[10,\"jk\",4,\"314\",99,\"crong\",false]"
        XCTAssertEqual(jsonString.removeWhiteSpaces(), noWhiteSpace)
    }
    
    func testHasNoSideSquareBracket() {
        let noSideSquareBracket = "10, \"jk\", 4, \"314\", 99, \"crong\""
        XCTAssertFalse(noSideSquareBracket.hasSideSquareBrackets())
    }
    
    func testHasOneSideSquartBracket() {
         let oneSideSquareBracket = "[10, \"jk\", 4, \"314\", 99, \"crong\""
        XCTAssertFalse(oneSideSquareBracket.hasSideSquareBrackets())
    }
    
    func testHasSideSquareBrackets() {
        let jsonString = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        XCTAssertTrue(jsonString.hasSideSquareBrackets())
    }
    
    func testTrimSquareBrackets() {
        let trimmedSquareBrackets = " 10, \"jk\", 4, \"314\", 99, \"crong\", false "
        let jsonString = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        XCTAssertEqual(jsonString.trimSquareBrackets(), trimmedSquareBrackets)
    }
    
    func testTrimDoubleQuotation() {
        let trimmedDoubleQuotation = "jamie"
        let stringSurroundedDoubleQuotation = "\"jamie\""
        XCTAssertEqual(stringSurroundedDoubleQuotation.trimDoubleQuotation(), trimmedDoubleQuotation)
    }
    
    func testSplitByComma() {
        let jsonString = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let splitArray = ["[ 10", " \"jk\"", " 4", " \"314\"", " 99", " \"crong\"", " false ]"]
        XCTAssertEqual(jsonString.splitByComma(), splitArray)
    }
    
}
