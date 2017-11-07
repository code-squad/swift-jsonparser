//
//  UnitTestJSONParser.swift
//  UnitTestJSONParser
//
//  Created by yangpc on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest
@testable import JSONParser

class UnitTestJSONParser: XCTestCase {
    var nestedObjectInObject: String!
    var nestedArrayInObject: String!
    var nestedObjectInArray: String!
    var nestedArrayInArray: String!
    
    var nestedArrayMoreThanTwo: String!
    var nestedObjectsInArray: String!
    var catchErrorSpellingTrue: String!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        nestedObjectInObject = "{ \"alias\" : {\"code squad\" : \"JK\", \"git hub\" : \"godrm\"} }"
        nestedArrayInObject = "{ \"children\" : [\"hana\", \"hayul\", \"haun\"] }"

        nestedObjectInArray = "[ { \"name\" : \"master's course\", \"opened\" : true } ]"
        nestedArrayInArray = "[ [ \"java\", \"javascript\", \"swift\" ] ]"

        // 2차 이상 중첩인 경우
        nestedArrayMoreThanTwo = "[[false, true, {\"name\":\"heejung\"}]]"
        
        // 배열 내부에 객체 하나 이상 있는 경우
        nestedObjectsInArray = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
        catchErrorSpellingTrue = "[ {\"visit\":ture} ]"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        nestedObjectInObject = nil
        nestedArrayInObject = nil
        nestedObjectInArray = nil
        nestedArrayInArray = nil
        
        nestedArrayMoreThanTwo = nil
        nestedObjectsInArray = nil
        catchErrorSpellingTrue = nil
    }
    
    func testMakeObject() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: nestedObjectInObject))
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: nestedArrayInObject))
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: nestedObjectInArray))
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: nestedArrayInArray))
        
        XCTAssertThrowsError(try JSONAnalyzer.makeObject(with: nestedArrayMoreThanTwo))
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: nestedObjectsInArray))
        XCTAssertThrowsError(try JSONAnalyzer.makeObject(with: catchErrorSpellingTrue))
    }
    
}
