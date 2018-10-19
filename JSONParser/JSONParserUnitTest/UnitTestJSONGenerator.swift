//
//  JSONParserUnitTest.swift
//  JSONParserUnitTest
//
//  Created by 윤지영 on 19/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest

class UnitTestJSONGenerator: XCTestCase {
    override func setUp() {}
    override func tearDown() {}

    func testExtractStringArray_whenValid() {
        let jsonString = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let jsonStringArray = ["10", "\"jk\"", "4", "\"314\"", "99", "\"crong\"", "false"]
        XCTAssertEqual(JSONGenerator.extractStringArray(from: jsonString), jsonStringArray)
    }
    
    func testExtractNil_whenNoSideSquareBracke() {
        let noSideSquareBracket = "10, \"jk\", 4, \"314\", 99, \"crong\""
        XCTAssertNil(JSONGenerator.extractStringArray(from: noSideSquareBracket))
    }
    
    func testExtractNil_whenOneLeftSideSquareBracke() {
        let oneLeftSideSquareBracket = "[10, \"jk\", 4, \"314\", 99, \"crong\""
        XCTAssertNil(JSONGenerator.extractStringArray(from: oneLeftSideSquareBracket))
    }
    
    func testExtractNil_whenOneRightSideSquareBracke() {
        let oneRightSideSquareBracket = "10, \"jk\", 4, \"314\", 99, \"crong\"]"
        XCTAssertNil(JSONGenerator.extractStringArray(from: oneRightSideSquareBracket))
    }
}
