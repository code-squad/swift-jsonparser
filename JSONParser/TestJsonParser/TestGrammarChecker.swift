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
    
    // 객체데이터 3개 : 문자열1, 불1, 숫자1
    func testIsGrammerCheckerPassed_SimpleObject_01 () {
        let validInput = """
    { "name" : "hoon" , "married" : false, "age" : 33}
    """
        XCTAssertNoThrow(try GrammerChecker.makeValidString(values: validInput))
    }
    
    // 객체데이터 5개 : 문자열2, 불2, 숫자1
    func testIsGrammerCheckerPassed_SimpleObject_02 () {
        let validInput = """
    { "nationality" : "South Korea" , "power" : "middle", "isHuge" : false, "population" : 50000000, "hasNuclear" : false}
    """
        XCTAssertNoThrow(try GrammerChecker.makeValidString(values: validInput))
    }
    
    // 중첩된 객체 : 문자열, 숫자, 배열
    func testIsGrammerCheckerPassed_NestedObject_01 () {
        let validInput = """
    { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "children" : ["hana", "hayul", "haun"] }
    """
         XCTAssertNoThrow(try GrammerChecker.makeValidString(values: validInput))
    }
    
    // 중첩된 객체 : 문자열, 불, 배열
    func testIsGrammerCheckerPassed_NestedObject_02 () {
        let validInput = """
    { "color" : "blue", "isBright" : true, "count" : 20, "kindOfColor" : ["blue", "red", "white"] }
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
    
    // 단순배열 : 객체1
    func testIsGrammerCheckerPassed_SimpleArray_01 () {
        let validInput = """
    [ { "name" : "master's course", "opened" : true }, [ "java", "javascript", "swift" ], 123, false ]
    """
        XCTAssertNoThrow(try GrammerChecker.makeValidString(values: validInput))
    }
    
    // 단순배열2 : 객체2
    func testIsGrammerCheckerPassed_SimpleArray_02 () {
        let validInput = """
    [ { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true }, { "name" : "YOON JISU", "alias" : "crong", "level" : 4, "married" : true } ]
    """
        XCTAssertNoThrow(try GrammerChecker.makeValidString(values: validInput))
    }
    
    // 중첩배열1 : 객체1, 배열1, 숫자, 불
    func testIsGrammerCheckerPassed_NestedArray_01 () {
        let validInput = """
    [ { "name" : "master's course", "opened" : true }, [ "java", "javascript", "swift" ], 123, false ]
    """
        XCTAssertNoThrow(try GrammerChecker.makeValidString(values: validInput))
    }
    
    // 중첩배열2 : 객체1, 배열1, 문자열2, 불값2, 숫자1
    func testIsGrammerCheckerPassed_NestedArray_02 () {
        let validInput = """
    [{"name" : "jh", "married":false}, "age", true, "korea", false, 451, ["haha","hoho"]]
    """
        XCTAssertNoThrow(try GrammerChecker.makeValidString(values: validInput))
    }
    
    // 중첩배열2 : 객체1, 배열1, 문자열1, 불값2, 숫자1
    func testIsGrammerCheckerPassed_NestedArray_03 () {
        let validInput = """
    [ { "name" : "dd" , "asd" : "asd" }, "add", true, false, 451, ["da","dad"] ]
    """
        XCTAssertNoThrow(try GrammerChecker.makeValidString(values: validInput))
    }
}


