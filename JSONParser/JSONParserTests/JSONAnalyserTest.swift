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
    var jsonData : JSONData!
    let tester : Array<String> = [ "10", "\"jk\"", "4", "\"314\"", "99", "\"crong\"", "false" ]
    var objectTester : Array<String> = ["{\"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true}"]
    let nestedArrayTester : Array<String> = ["{ \"test\" : \"tester\" }","[1,2,3]"]
    let nestedObjectTester : Array<String> = ["{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"], \"test\" : { \"test\" : \"tester\" } }"]
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        jsonData = nil
    }

    func testGetJSONData() {
        jsonData = JSONAnalyser.getJSONData(items: tester)
        XCTAssertTrue(jsonData[0] is Int)
        XCTAssertTrue(jsonData[1] is String)
        XCTAssertTrue(jsonData[2] is Int)
        XCTAssertTrue(jsonData[3] is String)
        XCTAssertTrue(jsonData[4] is Int)
        XCTAssertTrue(jsonData[5] is String)
        XCTAssertTrue(jsonData[6] is Bool)
    }
    
    func testGetJSONDataFromObject() {
        jsonData = JSONAnalyser.getJSONData(items: objectTester)
        XCTAssertTrue(jsonData[0] is JSONObject)
        let dic : JSONObject = jsonData[0] as! JSONObject
        XCTAssertEqual(dic.count, 4)
    }
    
    func testGetJSONDataForNestedArray() {
        jsonData = JSONAnalyser.getJSONData(items: nestedArrayTester)
        XCTAssertTrue(jsonData[0] is JSONObject)
        XCTAssertTrue(jsonData[1] is JSONData)
    }
    
    func testGetJSONDataForNestedObject() {
        jsonData = JSONAnalyser.getJSONData(items: nestedObjectTester)
        XCTAssertTrue(jsonData[0] is JSONObject)
    }
    
}
