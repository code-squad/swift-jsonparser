//
//  UnitTestTypeInspector.swift
//  JSONParserUnitTest
//
//  Created by 윤지영 on 19/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest

class UnitTestTypeInspector: XCTestCase {
    override func setUp() {}
    override func tearDown() {}
    
    func testCountStringType() {
        let jsonStringArray = ["10", "\"jk\"", "4", "\"314\"", "99", "\"crong\"", "false", "a"]
        XCTAssertEqual(StringInspector.countType(in: jsonStringArray), 3)
    }
    
    func testCountNumber() {
        let jsonStringArray = ["10", "\"jk\"", "4", "\"314\"", "99", "\"crong\"", "false", "a"]
        XCTAssertEqual(DoubleInspector.countType(in: jsonStringArray), 3)
    }
    
    func testCountNumberIncludingDouble() {
        let jsonIncludingDouble = ["\"314\"", "99.12", "\"crong\"", "false"]
        XCTAssertEqual(DoubleInspector.countType(in: jsonIncludingDouble), 1)
    }
    
    func testCountBool() {
        let jsonStringArray = ["10", "\"jk\"", "4", "\"314\"", "99", "\"crong\"", "false", "a"]
        XCTAssertEqual(BooleanInspector.countType(in: jsonStringArray), 1)
    }
    
    func testCountOnlyValidBool() {
        let jsonIncludeInvalidBool = ["flase", "ttrue", "Truee", "false"]
        XCTAssertEqual(BooleanInspector.countType(in: jsonIncludeInvalidBool), 1)
    }
}
