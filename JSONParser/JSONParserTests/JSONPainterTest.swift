//
//  JSONPainterTest.swift
//  JSONParserTests
//
//  Created by TaeHyeonLee on 2017. 11. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest

@testable import JSONParser

class JSONPainterTest: XCTestCase {
    var jsonPainter: JSONPainter?

    override func setUp() {
        super.setUp()
        jsonPainter = JSONPainter()
    }

    override func tearDown() {
        jsonPainter = nil
        super.tearDown()
    }

    func testJSONArray() {
        var jsonArray: JSONArray = JSONArray()
        jsonArray.add(element: 1)
        jsonArray.add(element: "jake")
        jsonArray.add(element: 3)
        jsonPainter?.paintJSON(jsonType: jsonArray)
        XCTAssertEqual(jsonPainter?.jsonPainting, "[1, jake, 3]")
    }

    func testJSONObject() {
        var jsonObject: JSONObject = JSONObject()
        jsonObject.add(keyValue: (key: "name", value: "jake"))
        jsonObject.add(keyValue: (key: "distance", value: 100))
        jsonPainter?.paintJSON(jsonType: jsonObject)
        XCTAssertEqual(jsonPainter?.jsonPainting, "{\n\t\"name\" : \"jake\",\n\t\"distance\" : 100\n}")
    }

    func testNestedJSONArray() {
        var jsonArray: JSONArray = JSONArray()
        jsonArray.add(element: 1)
        jsonArray.add(element: ["jake", "jk"])
        jsonArray.add(element: 3)
        jsonPainter?.paintJSON(jsonType: jsonArray)
        XCTAssertEqual(jsonPainter?.jsonPainting, "[1, [\"jake\", \"jk\"], 3]")
    }

    func testNestedJSONObject() {
        var jsonObject: JSONObject = JSONObject()
        jsonObject.add(keyValue: (key: "name", value: "jake"))
        jsonObject.add(keyValue: (key: "distance", value: 100))
        jsonObject.add(keyValue: (key: "object", value: ["master","jk"]))
        jsonPainter?.paintJSON(jsonType: jsonObject)
        XCTAssertEqual(jsonPainter?.jsonPainting, "{\n\t\"object\" : [\"master\", \"jk\"],\n\t\"name\" : \"jake\",\n\t\"distance\" : 100\n}")
    }

}
