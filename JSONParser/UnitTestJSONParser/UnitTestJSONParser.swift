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
    var formatErrorNestedArrayInObject: String!
    
    var nestedObjectInArray: String!
    var nestedArrayInArray: String!
    var nestedArrayAndObjectInArray: String!
    var nestedArrayAndObjectInArrayNoComma: String!
    
    var primitiveTypeInArray: String!
    var primitiveTypeInArrayNoComma: String!
    var primitiveTypeInArraywithLastDataComma: String!
    
    var nestedArrayMoreThanTwo: String!
    var nestedObjectsInArray: String!
    var catchErrorSpellingTrue: String!
    
    var nestedOneObjectAndPrimitiveTypeInArray: String!
    var nestedTwoObjectAndPrimitiveTypeInArray: String!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // [Not Nil] 오브젝트 내부에 중첩 오브젝트
        nestedObjectInObject = "{ \"alias\" : {\"code squad\" : \"JK\", \"git hub\" : \"godrm\"} }"
        // [Not Nil] 오브젝트 내부에 중첩 배열
        nestedArrayInObject = "{ \"children\" : [\"hana\", \"hayul\", \"haun\"] }"

        // [throw Error] 오브젝트 내부 형식이 잘 못 됐을 때
        formatErrorNestedArrayInObject = "{ \"children\" : {\"hana\", \"hayul\", \"haun\"} }"
        
        // [Not Nil] 배열 내부에 객체
        nestedObjectInArray = "[ { \"name\" : \"master's course\", \"opened\" : true } ]"
        
        // [Not Nil] 배열 내부에 배열
        nestedArrayInArray = "[ [ \"java\", \"javascript\", \"swift\" ] ]"
        
        // [Not Nil] 배열 내부에 객체와 배열
        //nestedArrayAndObjectInArray = "[ [20, \"hee jung\"], { \"code squad\" : \"level 2\" }]"
        nestedArrayAndObjectInArray = "[{\"code squad\":\"5\"},[\"f\",6]]"
        
        // [throw Error] 배열 내부 객체와 배열 사이에 쉼표가 없을 때
        nestedArrayAndObjectInArrayNoComma = "[ [20, \"hee jung\"]  { \"code squad\" : \"level 2\" }]"

        // [Not Nil] 기본 배열에 원시 타입 있는 경우
        primitiveTypeInArray = "[ 4, false, \"hello world\" ]"
        // [throw Error] 기본 배열 원시 타입 사이에 쉼표가 없는 경우
        primitiveTypeInArrayNoComma = "[ 4 false, \"hello world\" ]"
        // [throw Error] 기본 배열 원시 타입들의 가장 마지막에 쉼표가 있는 경우
        primitiveTypeInArraywithLastDataComma = "[ 4, false, \"hello world\", ]"
        
        // [throw Error] 2차 이상 중첩인 경우
        nestedArrayMoreThanTwo = "[[false, true, {\"name\":\"heejung\"}]]"
        
        // [Not Nil] 배열 내부에 객체 하나 이상 있는 경우
        nestedObjectsInArray = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
        // [throw Error] 스팰링 에러
        catchErrorSpellingTrue = "[ {\"visit\":ture} ]"
        
        nestedOneObjectAndPrimitiveTypeInArray = "[{\"code squad\":\"hj\"},\"f\"]"
        nestedTwoObjectAndPrimitiveTypeInArray = "[ { \"code squad\" : \"level 2\", \"name\" : \"heejung\" }, 5]"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        nestedObjectInObject = nil
        nestedArrayInObject = nil
        
        formatErrorNestedArrayInObject = nil
        
        nestedObjectInArray = nil
        nestedArrayInArray = nil
        nestedArrayAndObjectInArray = nil
        nestedArrayAndObjectInArrayNoComma = nil
        
        primitiveTypeInArray = nil
        primitiveTypeInArrayNoComma = nil
        primitiveTypeInArraywithLastDataComma = nil
        
        nestedArrayMoreThanTwo = nil
        nestedObjectsInArray = nil
        catchErrorSpellingTrue = nil
        nestedOneObjectAndPrimitiveTypeInArray = nil
        nestedTwoObjectAndPrimitiveTypeInArray = nil
    }
    
    func testMakeObjectCaseObjectInObject() {
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: nestedObjectInObject))
    }
    
    func testMakeObjectCaseArrayInObject() {
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: nestedArrayInObject))
    }
    
    func testMakeObjectCaseFormatErrorInObject() {
        XCTAssertThrowsError(try JSONAnalyzer.makeObject(with: formatErrorNestedArrayInObject))
    }
    
    func testMakeObjectCaseObjectInArray() {
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: nestedObjectInArray))
    }
    
    func testMakeObjectCaseArrayInArray() {
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: nestedArrayInArray))
    }
    
    func testMakeObjectCaseArrayAndObjectInArray() {
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: nestedArrayAndObjectInArray))
    }
    
    func testMakeObjectCaseNestedArrayWithNoComma() {
        XCTAssertThrowsError(try JSONAnalyzer.makeObject(with: nestedArrayAndObjectInArrayNoComma))
    }
    
    func testMakeObjectCasePrimitiveTypeInArray() {
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: primitiveTypeInArray))
    }
    
    func testMakeObjectCaseArrayWithNoComma() {
        XCTAssertThrowsError(try JSONAnalyzer.makeObject(with: primitiveTypeInArrayNoComma))
    }
    
    func testMakeObjectCaseArrayWithLastDataComma() {
        XCTAssertThrowsError(try JSONAnalyzer.makeObject(with: primitiveTypeInArraywithLastDataComma))
    }
    
    func testMakeObjectCaseArraysInArray()   {
        XCTAssertThrowsError(try JSONAnalyzer.makeObject(with: nestedArrayMoreThanTwo))
    }
    
    func testMakeObjectCaseObjectsInArray() {
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: nestedObjectsInArray))
    }
    
    func testMakeObjectCaseSpellingErrorInTrue() {
        XCTAssertThrowsError(try JSONAnalyzer.makeObject(with: catchErrorSpellingTrue))
    }
    
    func testMakeObectCaseOneObjectAndPrimitiveTypeInArray() {
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: nestedOneObjectAndPrimitiveTypeInArray))
    }
    
    func testMakeObjectCaseTwoObjectAndPrimitiveTypeInArray() {
        XCTAssertNotNil(try JSONAnalyzer.makeObject(with: nestedTwoObjectAndPrimitiveTypeInArray))
    }
}
