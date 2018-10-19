//
//  UnitTestTypeInspector.swift
//  JSONParserUnitTest
//
//  Created by 윤지영 on 19/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest

class UnitTestTypeInspector: XCTestCase {
    let jsonStringArray = ["10", "\"jk\"", "4", "\"314\"", "99", "\"crong\"", "false", "a"]
    let jsonIncludingDouble = ["\"314\"", "99.12", "\"crong\"", "false"]
    let jsonIncludeInvalidBool = ["flase", "ttrue", "Truee", "False"]
    
    override func setUp() {}
    override func tearDown() {}
    
    func testCountStringType() {
        XCTAssertEqual(StringInspector.countType(in: jsonStringArray), 3)
    }
    
    func testCountNumber() {
        XCTAssertEqual(DoubleInspector.countType(in: jsonStringArray), 3)
    }
    
    func testCountNumberIncludingDouble() {
        XCTAssertEqual(DoubleInspector.countType(in: jsonIncludingDouble), 1)
    }
    
    func testCountBool() {
        XCTAssertEqual(BooleanInspector.countType(in: jsonStringArray), 1)
    }
    
    func testCountOnlyValidBool() {
        XCTAssertEqual(BooleanInspector.countType(in: jsonStringArray), 1)
    }
}
