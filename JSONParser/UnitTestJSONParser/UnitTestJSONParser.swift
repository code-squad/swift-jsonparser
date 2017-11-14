//
//  UnitTestJSONParser.swift
//  UnitTestJSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest
@testable import JSONParser

class UnitTestJSONParser: XCTestCase {
    
    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testJSONParserCASE1() {
        let parserTest = JSONParser()
        let testRawJSONData = "[ 10, 21, 4, 314, 99, 0, 72 ]"
        XCTAssertEqual(parserTest.makeJSONData(testRawJSONData).intTypeCount, 7)
        XCTAssertEqual(parserTest.makeJSONData(testRawJSONData).sumOfData, 7)
    }
    
    func testJSONParserCASE2() {
        let parserTest = JSONParser()
        let testRawJSONData = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        XCTAssertEqual(parserTest.makeJSONData(testRawJSONData).stringTypeCount, 3)
        XCTAssertEqual(parserTest.makeJSONData(testRawJSONData).intTypeCount, 3)
        XCTAssertEqual(parserTest.makeJSONData(testRawJSONData).boolTypeCount, 1)
        XCTAssertEqual(parserTest.makeJSONData(testRawJSONData).sumOfData, 7)
    }
    
    func testJSONParserCASE3() {
        let parserTest = JSONParser()
        let testRawJSONData = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false, true, \"lee\", 1024]"
        XCTAssertEqual(parserTest.makeJSONData(testRawJSONData).stringTypeCount, 4)
        XCTAssertEqual(parserTest.makeJSONData(testRawJSONData).intTypeCount, 4)
        XCTAssertEqual(parserTest.makeJSONData(testRawJSONData).boolTypeCount, 2)
        XCTAssertEqual(parserTest.makeJSONData(testRawJSONData).sumOfData, 10)
    }
    
    func testJSONParserCASE4() {
        let testRawJSONData = " 10, 21, 4, 314, 99, 0, 72 ]"
        XCTAssertThrowsError(try JSONParser.check(testRawJSONData))
    }
    
}
