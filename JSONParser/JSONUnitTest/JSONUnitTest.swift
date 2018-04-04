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
    
    func testJSONLexerNumbersSuccess() {
        let input = "[ 10, 20, 30, 40, 50]"
        var lexer = JSONLexer(input: input)
        let token = try! lexer.lex()
        var parser = JSONParser(token)
        let jsonData = try! parser.parse()
        
        XCTAssertEqual(jsonData.numberCount, 5, "should be equal")
        XCTAssertEqual(jsonData.stringCount, 0, "should be equal")
        XCTAssertEqual(jsonData.boolCount, 0, "should be equal")
        XCTAssertEqual(jsonData.arrayCount, 0, "should be equal")
        XCTAssertEqual(jsonData.objectCount, 0, "should be equal")
        XCTAssertEqual(jsonData.paranet.count, 5, "should be equal")
        XCTAssertEqual(jsonData.paranet.name, "배열", "should be equal")
        
    }
    
    
    func testJSONLexerNumbersAndStringSuccess() {
        let input = "[ 10, \"20\", 30, 40, 50, \"sdf\"]"
        var lexer = JSONLexer(input: input)
        let token = try! lexer.lex()
        var parser = JSONParser(token)
        let jsonData = try! parser.parse()
        
        XCTAssertEqual(jsonData.numberCount, 4, "should be equal")
        XCTAssertEqual(jsonData.stringCount, 2, "should be equal")
        XCTAssertEqual(jsonData.boolCount, 0, "should be equal")
        XCTAssertEqual(jsonData.arrayCount, 0, "should be equal")
        XCTAssertEqual(jsonData.objectCount, 0, "should be equal")
        XCTAssertEqual(jsonData.paranet.count, 6, "should be equal")
        XCTAssertEqual(jsonData.paranet.name, "배열", "should be equal")
    }

    func testJSONLexerNumbersAndStringsAndBoolsSuccess() {
        let input = "[ false, 10, \"2.0\", 30, 4.0, 50, \"sdf\"]"
        var lexer = JSONLexer(input: input)
        let token = try! lexer.lex()
        var parser = JSONParser(token)
        let jsonData = try! parser.parse()
        
        XCTAssertEqual(jsonData.numberCount, 4, "should be equal")
        XCTAssertEqual(jsonData.stringCount, 2, "should be equal")
        XCTAssertEqual(jsonData.boolCount, 1, "should be equal")
        XCTAssertEqual(jsonData.arrayCount, 0, "should be equal")
        XCTAssertEqual(jsonData.objectCount, 0, "should be equal")
        XCTAssertEqual(jsonData.paranet.count, 7, "should be equal")
        XCTAssertEqual(jsonData.paranet.name, "배열", "should be equal")
    }
    
    func testJSONLexerObjectSuccess() {
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        var lexer = JSONLexer(input: input)
        let token = try! lexer.lex()
        var parser = JSONParser(token)
        let jsonData = try! parser.parse()
        
        XCTAssertEqual(jsonData.numberCount, 1, "should be equal")
        XCTAssertEqual(jsonData.stringCount, 2, "should be equal")
        XCTAssertEqual(jsonData.boolCount, 1, "should be equal")
        XCTAssertEqual(jsonData.arrayCount, 0, "should be equal")
        XCTAssertEqual(jsonData.objectCount, 0, "should be equal")
        XCTAssertEqual(jsonData.paranet.count, 4, "should be equal")
        XCTAssertEqual(jsonData.paranet.name, "객체", "should be equal")
    }
    
    func testJSONLexerObjectInArray(){
        let input = "[{\"name\":\"KIm JUNG\", \"alias\":\"JK\", \"level\": 5, \"married\" : true }, { \"name\" : \"YOON JISU\",  \"alias\" : \"crong\", \"leve\", \"level\":4, \"married\":true}]"
        var lexer = JSONLexer(input: input)
        let token = try! lexer.lex()
        var parser = JSONParser(token)
        let jsonData = try! parser.parse()
        
        XCTAssertEqual(jsonData.numberCount, 0, "should be equal")
        XCTAssertEqual(jsonData.stringCount, 0, "should be equal")
        XCTAssertEqual(jsonData.boolCount, 0, "should be equal")
        XCTAssertEqual(jsonData.arrayCount, 0, "should be equal")
        XCTAssertEqual(jsonData.objectCount, 2, "should be equal")
        XCTAssertEqual(jsonData.paranet.count, 2, "should be equal")
        XCTAssertEqual(jsonData.paranet.name, "배열", "should be equal")
        
    }
    
    func testJSONLexerInvalidFormatObjectInArrayException(){
        let input = "[{\"name\":\"KIm JUNG\", \"alias\":\"JK\", \"level\": 5, \"married\" : true }, { \"name\" : \"YOON JISU\",  \"alias\" : \"crong\", \"leve\", \"level\":4, \"married\":true]"
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatObjectException(){
        let input = "{ false, 10, \"2.0\", 30, 4.0, 50, \"sdf\""
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatLexException(){
        let input = "sdf[ false, 10, \"2.0\", 30, 4.0, 50, \"sdf\""
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatBracketLexException(){
        let input = "[ false, 10, \"2.0\", 30, 4.0, 50, \"sdf\""
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatDoubleQuoteLexException(){
        let input = "[ false, 10, \"2.0, 30, 4.0, 50, \"sdf\""
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatBoolLexException(){
        let input = "[ falAse, 10, \"2.0, 30, 4.0, 50, \"sdf\""
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatNumberLexException(){
        let input = "[ false, 10, \"2.0\", 3-0, 4.0, 50, \"sdf\"]"
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatDoubleLexException(){
        let input = "[ false, 10, \"2.0\", 30, 4.-0, 50, \"sdf\"]"
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatObjectInArrayExceptionForStep3(){
        let input = "[\"name\" : \"KIM JUNG\"]"
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
    
    func testJSONLexerInvalidFormatArrayInObjectExceptionForStep3(){
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        var lexer = JSONLexer(input: input)
        XCTAssertThrowsError(try lexer.lex()) { error in
            print(error)
        }
    }
}
