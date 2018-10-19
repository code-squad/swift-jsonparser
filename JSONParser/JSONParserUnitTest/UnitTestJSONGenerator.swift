//
//  JSONParserUnitTest.swift
//  JSONParserUnitTest
//
//  Created by 윤지영 on 19/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest

class UnitTestJSONGenerator: XCTestCase {
    let jsonString = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
    let noSideSquareBracket = "10, \"jk\", 4, \"314\", 99, \"crong\""
    let oneLeftSideSquareBracket = "[10, \"jk\", 4, \"314\", 99, \"crong\""
    let oneRightSideSquareBracket = "10, \"jk\", 4, \"314\", 99, \"crong\"]"
    let jsonStringArray = ["10", "\"jk\"", "4", "\"314\"", "99", "\"crong\"", "false"]
    
    override func setUp() {}
    override func tearDown() {}

    func testExtractStringArray_whenValid() {
        XCTAssertEqual(JSONGenerator.extractStringArray(from: jsonString), jsonStringArray)
    }
    
    func testExtractNil_whenNoSideSquareBracke() {
        XCTAssertNil(JSONGenerator.extractStringArray(from: noSideSquareBracket))
    }
    
    func testExtractNil_whenOneLeftSideSquareBracke() {
        XCTAssertNil(JSONGenerator.extractStringArray(from: oneLeftSideSquareBracket))
    }
    
    func testExtractNil_whenOneRightSideSquareBracke() {
        XCTAssertNil(JSONGenerator.extractStringArray(from: oneRightSideSquareBracket))
    }
}
