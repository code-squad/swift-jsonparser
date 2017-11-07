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
    var nestedInObject: String!
    var nestedInArray: String!
    var nestedArrayMoreThanTwo: String!
    var nestedOnlyObjectInArray: String!
    var catchErrorSpellingTrue: String!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // 객체 내부의 key: value 에서 value에 객체, 배열, 원시 타입이 존재하는 경우 && 띄어씌기 무시
        nestedInObject = "{ \"name\" : \"KIM JUNG\", \"alias\" : {\"code squad\" : \"JK\", \"git hub\" : \"godrm\"}, \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        // 배열 내부에 객체, 배열 있는 경우
        nestedInArray = "[ { \"name\" : \"master's course\", \"opened\" : true }, [ \"java\", \"javascript\", \"swift\" ] ]"
        // 2차 이상 중첩인 경우
        nestedArrayMoreThanTwo = "[[false, true, {\"name\":\"heejung\"}]]"
        // 배열 내부에 객체만 있는 경우
        nestedOnlyObjectInArray = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
        catchErrorSpellingTrue = "[ {\"visit\":ture} ]"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        nestedInObject = nil
        nestedInArray = nil
        nestedArrayMoreThanTwo = nil
        nestedOnlyObjectInArray = nil
        catchErrorSpellingTrue = nil
    }
    
    func testMakeObject() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: nestedInObject))
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: nestedInArray))
        XCTAssertThrowsError(try JSONAnalyzer.makeObject(with: nestedArrayMoreThanTwo))
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: nestedOnlyObjectInArray))
        XCTAssertThrowsError(try JSONAnalyzer.makeObject(with: catchErrorSpellingTrue))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
