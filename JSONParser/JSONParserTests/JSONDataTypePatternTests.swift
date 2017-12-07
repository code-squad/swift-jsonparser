//
//  JSONDataTypePatternTest.swift
//  JSONParserTests
//
//  Created by yuaming on 2017. 12. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest

class JSONDataTypePatternTest: XCTestCase {

    func test_JSONData_객체_패턴_매칭_성공() {
        let inputValue = """
        { "name" : "master's course", "opened" : true, "language": [ "java", "javascript", "swift" ] }
        """
        XCTAssertTrue(try inputValue.matchPatterns(pattern: JSONDataTypePattern.object))
    }
    
    func test_JSONData_객체_패턴_매칭_실패() {
        let inputValue = """
        { "name" : "master's course", "opened"
        """
        XCTAssertThrowsError(try inputValue.matchPatterns(pattern: JSONDataTypePattern.object))
    }
    
    func test_JSONData_배열_패턴_매칭_성공() {
        let inputValue = """
        [ "java", "javascript", "swift", {"name" : 1234 }, 12345 ]
        """
        XCTAssertTrue(try inputValue.matchPatterns(pattern: JSONDataTypePattern.array))
    }
    
    func test_JSONData_배열_패턴_매칭_실패() {
        let inputValue = """
        [ "java", "javascript", "swift"
        """
        XCTAssertThrowsError(try inputValue.matchPatterns(pattern: JSONDataTypePattern.array))
    }
    
    func test_JSONData_문자_패턴_매칭_성공() {
        let inputValue = """
        "java"
        """
        XCTAssertTrue(try inputValue.matchPatterns(pattern: JSONDataTypePattern.string))
    }
    
    func test_JSONData_문자_패턴_매칭_실패() {
        let inputValue = """
        "test
        """
        XCTAssertThrowsError(try inputValue.matchPatterns(pattern: JSONDataTypePattern.string))
    }

    func test_JSONData_숫자_패턴_매칭_성공() {
        let inputValue = """
        123456
        """
        XCTAssertTrue(try inputValue.matchPatterns(pattern: JSONDataTypePattern.number))
    }
    
    func test_JSONData_숫자_패턴_매칭_실패() {
        let inputValue = """
        강현정
        """
        XCTAssertThrowsError(try inputValue.matchPatterns(pattern: JSONDataTypePattern.number))
    }
    
    func test_JSONData_플래그_패턴_매칭_성공() {
        let inputValue = """
        true
        """
        XCTAssertTrue(try inputValue.matchPatterns(pattern: JSONDataTypePattern.bool))
    }
    
    func test_JSONData_플래그_패턴_매칭_실패() {
        let inputValue = """
        null
        """
        XCTAssertThrowsError(try inputValue.matchPatterns(pattern: JSONDataTypePattern.bool))
    }
}
