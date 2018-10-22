//
//  UnitTestTypeInspector.swift
//  JSONParserUnitTest
//
//  Created by 윤지영 on 19/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest

class UnitTestTypeInspector: XCTestCase {
    var jsonArray: [Any?] = []
    var typeCount: [String: Int] = [:]
    
    override func setUp() {
        jsonArray = [10, "jk", 4, "314", 99, "crong", false, nil]
        typeCount = TypeInspector.countType(of: jsonArray)
    }
    override func tearDown() {}
    
    func testCountStringType() {
        XCTAssertEqual(typeCount[typeName.string.rawValue], 3)
    }

    func testCountNumber() {
        XCTAssertEqual(typeCount[typeName.int.rawValue], 3)
    }
    
    func testCountBool() {
        XCTAssertEqual(typeCount[typeName.bool.rawValue], 1)
    }
}
