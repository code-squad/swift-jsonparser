//
//  JSONUnitTest.swift
//  JSONUnitTest
//
//  Created by rhino Q on 2018. 3. 29..
//  Copyright © 2018년 JK. All rights reserved.

import XCTest
@testable import JSONParser

class JSONUnitTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func checkTokens(_ tokens:[Token]) -> (Int, Int, Int){
        var numberCount = 0
        var stringCount = 0
        var boolCount = 0
        for token in tokens{
            switch token {
            case .string:
                stringCount += 1
            case .bool:
                boolCount += 1
            case .number:
                numberCount += 1
            }
        }
        return (numberCount, stringCount, boolCount)
    }
    
    func testJSONLexerNumbersSuccess() {
        let input = "[ 10, 20, 30, 40, 50]"
        var lexer = JSONLexer(input: input)
        let tokens = try! lexer.lex()
        let (numberCount, stringCount, boolCount) = checkTokens(tokens)
        XCTAssertEqual(numberCount, 5, "should be equal")
        XCTAssertEqual(stringCount, 0, "should be equal")
        XCTAssertEqual(boolCount, 0, "should be equal")
    }
    
    
    func testJSONLexerNumbersAndStringSuccess() {
        let input = "[ 10, \"20\", 30, 40, 50, \"sdf\"]"
        var lexer = JSONLexer(input: input)
        let tokens = try! lexer.lex()
        let (numberCount, stringCount, boolCount) = checkTokens(tokens)
        XCTAssertEqual(numberCount, 4, "should be equal")
        XCTAssertEqual(stringCount, 2, "should be equal")
        XCTAssertEqual(boolCount, 0, "should be equal")
    }
    
    func testJSONLexerNumbersAndStringsAndBoolsSuccess() {
        let input = "[ false, 10, \"2.0\", 30, 4.0, 50, \"sdf\"]"
        var lexer = JSONLexer(input: input)
        let tokens = try! lexer.lex()
        let (numberCount, stringCount, boolCount) = checkTokens(tokens)
        XCTAssertEqual(numberCount, 4, "should be equal")
        XCTAssertEqual(stringCount, 2, "should be equal")
        XCTAssertEqual(boolCount, 1, "should be equal")
    }
    
    
    func testJSONLexerInvalidFormatLexExceptioin(){
        let input = "sdf[ false, 10, \"2.0\", 30, 4.0, 50, \"sdf\""
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatBracketLexExceptioin(){
        let input = "[ false, 10, \"2.0\", 30, 4.0, 50, \"sdf\""
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatDoubleQuoteLexExceptioin(){
        let input = "[ false, 10, \"2.0, 30, 4.0, 50, \"sdf\""
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatBoolLexExceptioin(){
        let input = "[ falAse, 10, \"2.0, 30, 4.0, 50, \"sdf\""
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatNumberLexExceptioin(){
        let input = "[ false, 10, \"2.0\", 3-0, 4.0, 50, \"sdf\"]"
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatDoubleLexExceptioin(){
        let input = "[ false, 10, \"2.0\", 30, 4.-0, 50, \"sdf\"]"
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
}
