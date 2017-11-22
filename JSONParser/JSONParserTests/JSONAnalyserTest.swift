//
//  JSONAnalyserTest.swift
//  JSONParserTests
//
//  Created by TaeHyeonLee on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest

@testable import JSONParser

class JSONAnalyserTest: XCTestCase {
    var jsonType: JSONType!
    var jsonAnalyser: JSONAnalyser!
    let tester: String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
    var objectTester : String = "{\"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true}"
    let nestedArrayTester : String = "[ { \"name\" : \"master's course\", \"opened\" : true }, [ \"java\", \"javascript\", \"swift\" ]]"
    let nestedObjectTester : String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"], \"test\" : { \"test\" : \"tester\" } }"
    
    override func setUp() {
        super.setUp()
        jsonAnalyser = JSONAnalyser()
    }
    
    override func tearDown() {
        super.tearDown()
        jsonType = nil
    }

    func testGetJSONData_Int() {
        let jsonArray = jsonAnalyser.getJSONType(inputValue: tester) as? JSONArray
        XCTAssertTrue(jsonArray?[0] is Int)
        XCTAssertTrue(jsonArray?[2] is Int)
        XCTAssertTrue(jsonArray?[4] is Int)
    }

    func testGetJSONData_String() {
        let jsonArray = jsonAnalyser.getJSONType(inputValue: tester) as? JSONArray
        XCTAssertTrue(jsonArray?[1] is String)
        XCTAssertTrue(jsonArray?[3] is String)
        XCTAssertTrue(jsonArray?[5] is String)
    }

    func testGetJSONData_Bool() {
        let jsonArray = jsonAnalyser.getJSONType(inputValue: tester) as? JSONArray
        XCTAssertTrue(jsonArray?[6] is Bool)
    }
    
    func testGetJSONDataFromObject() {
        let jsonObject = jsonAnalyser.getJSONType(inputValue: objectTester)
        XCTAssertTrue(jsonObject is JSONObject)

        let dictionary = jsonObject as? JSONObject
        XCTAssertEqual(dictionary?.count, 4)
    }
    
    func testGetJSONDataForNestedArray_JSONObject() {
        let jsonArray = jsonAnalyser.getJSONType(inputValue: nestedArrayTester) as? JSONArray
        XCTAssertTrue(jsonArray?[1] is JSONObject)
    }

    func testGetJSONDataForNestedArray_JSONArray() {
        let jsonArray = jsonAnalyser.getJSONType(inputValue: nestedArrayTester) as? JSONArray
        XCTAssertTrue(jsonArray?[0] is JSONArray)
    }
    
    func testGetJSONDataForNestedObject() {
        let jsonObject = jsonAnalyser.getJSONType(inputValue: nestedObjectTester) as? JSONObject
        XCTAssertTrue(jsonObject?["children"] is JSONArray)
    }
    
}
