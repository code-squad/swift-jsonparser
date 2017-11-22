//
//  UnitTestJSONParser.swift
//  UnitTestJSONParser
//
//  Created by Eunjin Kim on 2017. 11. 22..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest
@testable import JSONParser
class UnitTestJSONParser: XCTestCase {
    var jsonScanner1 = JsonScanner()
    var jsonScanner2 = JsonScanner()
    var jsonTypeCounter1 = JsonTypeCounter()
    var jsonTypeCounter2 = JsonTypeCounter()
    var data1 = DataInfo()
    var data2 = DataInfo()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testJSONParser1() {
        let token = try! jsonScanner1.scanOfJsonValue(jsonValue: "[ 10, 21, 4, 314, 99, 0, 72 ]")
        data1 = jsonTypeCounter1.countDataType(token: token)
        XCTAssertEqual(data1.countOfString, 0)
        XCTAssertEqual(data1.countOfNumber, 7)
        XCTAssertEqual(data1.countOfBool, 0)
    }
    
    func testJSONParser2() {
        let token = try! jsonScanner2.scanOfJsonValue(jsonValue: "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]")
        data2 = jsonTypeCounter2.countDataType(token: token)
        XCTAssertEqual(data2.countOfString, 3)
        XCTAssertEqual(data2.countOfNumber, 3)
        XCTAssertEqual(data2.countOfBool, 1)
    }
    
    func testPerformanceExample() {

    }
    
}
