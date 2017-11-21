//
//  JSONArrayTest.swift
//  JSONParserTests
//
//  Created by TaeHyeonLee on 2017. 11. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest

@testable import JSONParser

class JSONArrayTest: XCTestCase {
    var jsonArray: JSONArray!

    override func setUp() {
        super.setUp()
        jsonArray = JSONArray()
    }

    override func tearDown() {
        jsonArray = nil
        super.tearDown()
    }

    func testInit() {
        XCTAssertNotNil(jsonArray)
    }

    func testAdd() {
        jsonArray.add(element: 3)
        XCTAssertEqual(jsonArray.count, 1)

        jsonArray.add(element: "jake")
        XCTAssertEqual(jsonArray.count, 2)
    }

}
