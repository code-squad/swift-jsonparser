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
    let grammarChecker = GrammarChecker()
    var jsonData: JSONData!
    var jsonAnalyser: JSONAnalyser!
    let tester: String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
    var objectTester : String = "{\"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true}"
    let nestedArrayTester : String = "[ { \"name\" : \"master's course\", \"opened\" : true }, [ \"java\", \"javascript\", \"swift\" ]]"
    let nestedObjectTester : String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"], \"test\" : { \"test\" : \"tester\" } }"
    
    override func setUp() {
        super.setUp()
        jsonAnalyser = JSONAnalyser.init(grammarChecker: grammarChecker)
    }
    
    override func tearDown() {
        super.tearDown()
        jsonData = nil
    }

    func testGetJSONData() {
        jsonData = jsonAnalyser.getJSONData(inputValue: tester)
        XCTAssertTrue(jsonData[0] is Int)
        XCTAssertTrue(jsonData[1] is String)
        XCTAssertTrue(jsonData[2] is Int)
        XCTAssertTrue(jsonData[3] is String)
        XCTAssertTrue(jsonData[4] is Int)
        XCTAssertTrue(jsonData[5] is String)
        XCTAssertTrue(jsonData[6] is Bool)
    }
    
    func testGetJSONDataFromObject() {
        jsonData = jsonAnalyser.getJSONData(inputValue: objectTester)
        XCTAssertTrue(jsonData[0] is JSONObject)
        let dic : JSONObject = jsonData[0] as! JSONObject
        XCTAssertEqual(dic.count, 4)
    }
    
    func testGetJSONDataForNestedArray() {
        jsonData = jsonAnalyser.getJSONData(inputValue: nestedArrayTester)
        XCTAssertTrue(jsonData[0] is JSONObject)
        XCTAssertTrue(jsonData[1] is JSONData)
    }
    
    func testGetJSONDataForNestedObject() {
        jsonData = jsonAnalyser.getJSONData(inputValue: nestedObjectTester)
        XCTAssertTrue(jsonData[0] is JSONObject)
    }
    
}
