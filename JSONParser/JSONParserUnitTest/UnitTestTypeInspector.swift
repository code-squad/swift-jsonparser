//
//  UnitTestTypeInspector.swift
//  JSONParserUnitTest
//
//  Created by 윤지영 on 19/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest

class UnitTestTypeInspector: XCTestCase {
    var jsonValues: [JSONValue] = []
    var typeCount: [String: Int] = [:]
    
    override func setUp() {
        jsonValues = [JSONValue.int(10), JSONValue.string("jamie"), JSONValue.bool(true), JSONValue.object(["name": JSONValue.string("jiyeong Yun")]), JSONValue.int(24), JSONValue.bool(false)]
        typeCount = TypeInspector.countType(of: jsonValues)
    }
    override func tearDown() {}

    func testCountString() {
        XCTAssertEqual(typeCount[typeName.string.rawValue], 1)
    }

    func testCountNumber() {
        XCTAssertEqual(typeCount[typeName.int.rawValue], 2)
    }
    
    func testCountBool() {
        XCTAssertEqual(typeCount[typeName.bool.rawValue], 2)
    }
    
    func testCountObject() {
        XCTAssertEqual(typeCount[typeName.object.rawValue], 1)
    }
}
