//
//  JSONParserTest.swift
//  JSONParserTest
//
//  Created by Jung seoung Yeo on 2018. 5. 11..
//  Copyright © 2018년 JK. All rights reserved.
//

import XCTest

class JSONParserTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK : 정규식 문자열
    func test_알파벳으로만된문자열검사() {
        let expectedString = "\"string\""
        XCTAssertTrue(expectedString.isMatching(expression: NSRegularExpression(pattern : Regex.string.description)))
    }
    
    func test_숫자로만된문자열검사() {
        let expectedString = "\"123456789\""
        XCTAssertTrue(expectedString.isMatching(expression: NSRegularExpression(pattern : Regex.string.description)))
    }
    
    func test_대문자로만된문자열검사() {
        let expectedString = "\"FALSE\""
        XCTAssertTrue(expectedString.isMatching(expression: NSRegularExpression(pattern : Regex.string.description)))
    }
    
    func test_숫잦와알파벳으로된문자열검사() {
        let expectedString = "\"TRUE123false\""
        XCTAssertTrue(expectedString.isMatching(expression: NSRegularExpression(pattern : Regex.string.description)))
    }
    
    func test_숫자검사() {
        let expectedNumber = "123456"
        XCTAssertTrue(expectedNumber.isMatching(expression: NSRegularExpression(pattern: Regex.number.description)))
    }
    
    func test_부울검사() {
        let expectedNumber = "false"
        XCTAssertTrue(expectedNumber.isMatching(expression: NSRegularExpression(pattern: Regex.boolean.description)))
    }
    
    // MAKR :: Lexer
    func test_렉서갯수검사() {
        let expectedInputNumber = "[123,123,123]"
        let numberLex = Lexer.init(expectedInputNumber).lex()
        
        let expectedInputString = "[\"string\",\"false\"]"
        let stringLex = Lexer.init(expectedInputString).lex()
        
        let expectedInputBoolean = "[false,False,true,True]"
        let booleanLex = Lexer.init(expectedInputBoolean).lex()
        
        let expectedInputObjectString = "{\"key\":\"value\"}"
        let objectStringLex = Lexer.init(expectedInputObjectString).lex()
        
        let expectedInputObjectNumber = "{\"key\":123456}"
        let objectNumberLex = Lexer.init(expectedInputObjectNumber).lex()
        
        let expectedInputObjectBoolean = "{\"key\":false}"
        let objectBooleanLex = Lexer.init(expectedInputObjectBoolean).lex()
        
        XCTAssertEqual(7, numberLex.count)
        XCTAssertEqual(5, stringLex.count)
        XCTAssertEqual(9, booleanLex.count)
        
        XCTAssertEqual(5, objectStringLex.count)
        XCTAssertEqual(5, objectNumberLex.count)
        XCTAssertEqual(5, objectBooleanLex.count)
    }
    
    // MAKR :: Parse
    
    func test_유효한렉서검사() throws {
        let expectedArray = "[123,123,123]"
        let arrayLex = Lexer(expectedArray).lex()
        XCTAssertNoThrow(try Parser(arrayLex).parse())
    }
    
    func test_괄호검사() throws {
        let unExpectedBracketClose = "[123,345"
        let unExpectedBraceClose = "{\"key\":123"
        let expectBracketClose = "[123,123,123]"
        let expectBraceClose = "{\"key\":123}"
        
        let unBracketLex = Lexer(unExpectedBracketClose).lex()
        let unBraceLex = Lexer(unExpectedBraceClose).lex()
        
        let bracketLex = Lexer(expectBracketClose).lex()
        let braceLex = Lexer(expectBraceClose).lex()
        
        XCTAssertThrowsError(try Parser(unBracketLex).parse())
        XCTAssertThrowsError(try Parser(unBraceLex).parse())
        
        XCTAssertNoThrow(try Parser(bracketLex).parse())
        XCTAssertNoThrow(try Parser(braceLex).parse())
    }
}
