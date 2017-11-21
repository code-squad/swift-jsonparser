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
        XCTAssertEqual(jsonArray.JSONArray.count, 1)
        XCTAssertEqual(jsonArray.JSONData.count, 1)

        jsonArray.add(element: "jake")
        XCTAssertEqual(jsonArray.JSONArray.count, 2)
        XCTAssertEqual(jsonArray.JSONData.count, 2)
    }

}
