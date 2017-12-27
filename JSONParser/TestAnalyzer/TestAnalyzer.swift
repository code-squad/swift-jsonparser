//
//  TestAnalyzer.swift
//  TestAnalyzer
//
//  Created by Choi Jeong Hoon on 2017. 12. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest

class TestAnalyzer: XCTestCase {
    
    // Mark : 타입카운팅 배열 요소 갯수 정상 여부 테스트
    // 단순배열
    func testIsSuccessMakingCountedArrayTypeInstance () {
        let uncheckedValues = """
    [120, "minimum", 12,"Jazz",2015, true]
    """
        let checkedValues = try! GrammerChecker.makeValidString(values: uncheckedValues)
        let analyzedValue = Analyzer.makeAnalyzedTypeInstance(checkedValues)
        let countedType: JsonData = CountingJsonData.makeCountedTypeInstance(analyzedValue)
        XCTAssertEqual(countedType.ofBooleanValue, 1)
        XCTAssertEqual(countedType.ofNumericValue, 3)
        XCTAssertEqual(countedType.ofStringValue, 2)
        XCTAssertEqual(countedType.total, 6)
    }
    
    // 중첩배열 : 객체, 문자열, 인트, 불, 배열
    func testIsSuccessMakingCountedNestedArrayTypeInstance () {
        let uncheckedValues = """
    [{"name" : "jh", "married":false}, "age", true, "korea", false, 451, ["haha","hoho"]]
    """
        let checkedValues = try! GrammerChecker.makeValidString(values: uncheckedValues)
        let analyzedValue = Analyzer.makeAnalyzedTypeInstance(checkedValues)
        let countedType: JsonData = CountingJsonData.makeCountedTypeInstance(analyzedValue)
        XCTAssertEqual(countedType.ofObject, 1)
        XCTAssertEqual(countedType.ofNumericValue, 1)
        XCTAssertEqual(countedType.ofBooleanValue, 2)
        XCTAssertEqual(countedType.ofStringValue, 2)
        XCTAssertEqual(countedType.ofArray, 1)
        XCTAssertEqual(countedType.total, 7)
    }
    
    // 중첩배열2 : 배열, 배열
    func testIsSuccessMakingCountedNestedArraySecondTypeInstance () {
        let uncheckedValues = """
    [ [ "name","KIM JUNG", "JK", "level"], [ "name","YOON JISU", "alias" , "level", "married" ] ]
    """
        let checkedValues = try! GrammerChecker.makeValidString(values: uncheckedValues)
        let analyzedValue = Analyzer.makeAnalyzedTypeInstance(checkedValues)
        let countedType: JsonData = CountingJsonData.makeCountedTypeInstance(analyzedValue)
        XCTAssertEqual(countedType.ofArray, 2)
        XCTAssertEqual(countedType.total, 2)
    }
    
    // 중첩배열3 : 객체, 객체
    func testIsSuccessMakingCountedNestedArrayThirdTypeInstance () {
        let uncheckedValues = """
    [ { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true }, { "name" : "YOON JISU", "alias" : "crong", "level" : 4, "married" : true } ]
    """
        let checkedValues = try! GrammerChecker.makeValidString(values: uncheckedValues)
        let analyzedValue = Analyzer.makeAnalyzedTypeInstance(checkedValues)
        let countedType: JsonData = CountingJsonData.makeCountedTypeInstance(analyzedValue)
        XCTAssertEqual(countedType.ofObject, 2)
        XCTAssertEqual(countedType.total, 2)
    }
    
    // Mark : 타입카운팅 객체 요소 갯수 정상 여부 테스트
    // 단순객체
    func testIsSuccessMakingCountedObjectTypeInstance () {
        let uncheckedValues = """
    { "name" : "hoon" , "married" : false, "age" : 33}
    """
        let checkedValues = try! GrammerChecker.makeValidString(values: uncheckedValues)
        let analyzedValue = Analyzer.makeAnalyzedTypeInstance(checkedValues)
        let countedType: JsonData = CountingJsonData.makeCountedTypeInstance(analyzedValue)
        XCTAssertEqual(countedType.ofBooleanValue, 1)
        XCTAssertEqual(countedType.ofNumericValue, 1)
        XCTAssertEqual(countedType.ofStringValue, 1)
        XCTAssertEqual(countedType.total, 3)
    }
    
    // 중첩객체 : 인트, 불, 스트링, 배열
    func testIsSuccessMakingCountedNestedObjectTypeInstance () {
        let uncheckedValues = """
    { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "children" : ["hana", "hayul", "haun"], "Courses" : ["IOs", "front", "back"]}
    """
        let checkedValues = try! GrammerChecker.makeValidString(values: uncheckedValues)
        let analyzedValue = Analyzer.makeAnalyzedTypeInstance(checkedValues)
        let countedType: JsonData = CountingJsonData.makeCountedTypeInstance(analyzedValue)
        XCTAssertEqual(countedType.ofNumericValue, 1)
        XCTAssertEqual(countedType.ofBooleanValue, 0)
        XCTAssertEqual(countedType.ofStringValue, 2)
        XCTAssertEqual(countedType.ofArray, 2)
        XCTAssertEqual(countedType.total, 5)
    }
}
