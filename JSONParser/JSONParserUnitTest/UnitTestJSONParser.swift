//
//  JSONParserUnitTest.swift
//  JSONParserUnitTest
//
//  Created by 윤지영 on 19/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest

class UnitTestJSONParser: XCTestCase {
    override func setUp() {}
    override func tearDown() {}
    
    func testMakeJSONArrayNil_whenStringHasNoTwoSquareBrackets() {
        let jsonStringWithOneSquareBracket = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false"
        XCTAssertNil(JSONParser.makeJSONArray(from: jsonStringWithOneSquareBracket))
    }

    func testJSONArrayStoresRightType_Int() {
        let jsonString = "[ 10, \"jk\", 4, \"314\", 99, false, a ]"
        let jsonArray = JSONParser.makeJSONArray(from: jsonString)
        XCTAssertTrue(jsonArray?[0] is Int)
    }
    
    func testJSONArrayStoresRightType_String() {
        let jsonString = "[ 10, \"jk\", 4, \"314\", 99, false, a ]"
        let jsonArray = JSONParser.makeJSONArray(from: jsonString)
        XCTAssertTrue(jsonArray?[1] is String)
    }
    
    func testJSONArrayStoresRightType_Bool() {
        let jsonString = "[ 10, \"jk\", 4, \"314\", 99, false, a ]"
        let jsonArray = JSONParser.makeJSONArray(from: jsonString)
        XCTAssertTrue(jsonArray?[5] is Bool)
    }
    
    func testJSONArrayStoresRightType_Nil() {
        let jsonString = "[ 10, \"jk\", 4, \"314\", 99, false, a ]"
        let jsonArray = JSONParser.makeJSONArray(from: jsonString)
        XCTAssertNil(jsonArray?[6])
    }
}
