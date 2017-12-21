//
//  TestJsonParser.swift
//  TestJsonParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 15..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest

class TestGrammarChcker: XCTestCase {
    
    // Mark : 객체 문법통과 실패 테스트
    
    // 객체 좌측 중괄호가 없는 경우
    func testErrorOfNoLeftBrace () {
        let invalidInput = """
    "name" : "master's course", "opened" }
    """
        XCTAssertThrowsError(try GrammerChecker.makeValidString(values: invalidInput))
    }
    
    // 객체 우측 중괄호가 없는 경우
    func testErrorOfNoRightBrace () {
        let invalidInput = """
    { "name" : "master's course", "opened"
    """
        XCTAssertThrowsError(try GrammerChecker.makeValidString(values: invalidInput))
    }
    
    // 객체에 배열이 들어있는 경우
    func testErrorOfUnSupportedArrayInObject () {
        let invalidInput = """
         { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "children" : ["hana", "hayul", "haun"] }
        """
        XCTAssertThrowsError(try GrammerChecker.makeValidString(values: invalidInput))
    }
    
    // 객체에 밸류위치에 쉼표없이 숫자와문자가 붙어있는 경우
    func testErrorOfLinkedValueWithoutCommaInObject () {
        let invalidInput = """
         { "name" : "KIM JUNG"5}
        """
        XCTAssertThrowsError(try GrammerChecker.makeValidString(values: invalidInput))
    }
    
    // Mark : 객체 문법통과 성공 테스트
    
    // 객체데이터 3개
    func testIsObjectGrammerCheckerPassed () {
        let validInput = """
    { "name" : "hoon" , "married" : false, "age" : 33}
    """
        XCTAssertNoThrow(try GrammerChecker.makeValidString(values: validInput))
    }
    
    // Mark : 배열 문법통과 실패 테스트
    
    // 배열 좌측 대괄호가 없는 경우
    func testErrorOfNoLeftSquareBracket () {
        let invalidInput = """
                    123, false, "Jeonghoon"]"
    """
        XCTAssertThrowsError(try GrammerChecker.makeValidString(values: invalidInput))
    }
    
    // 배열 우측 대괄호가 없는 경우
    func testErrorOfNoRightSquareBracket () {
        let invalidInput = """
                    [123, false, "Jeonghoon"
    """
        XCTAssertThrowsError(try GrammerChecker.makeValidString(values: invalidInput))
    }
    
    // 배열에 쉼표없이 값이 붙어있는 경우
    func testErrorOfLinkedValueWithoutCommaInArray () {
        let invalidInput = """
         [ "KIM JUNG"521313false ]
        """
        XCTAssertThrowsError(try GrammerChecker.makeValidString(values: invalidInput))
    }
    
    // Mark : 배열 문법통과 성공 테스트
    
    
    // 배열데이터 5개
    func testIsArrayGrammerCheckerPassed () {
        let validInput = """
    [ { "name" : "KIM JUNG", "alias" : "JK"}, "level", 5, true, "JeongHoon" ]
    """
        XCTAssertNoThrow(try GrammerChecker.makeValidString(values: validInput))
    }
    
}


