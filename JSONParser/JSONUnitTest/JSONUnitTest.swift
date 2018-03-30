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
    
    func testJSONParserNumbers() {
        let input = "[ 10, 20, 30, 40, 50]"
        var lexer = JSONLexer(input: input)
        let tokens = try! lexer.lex()
        XCTAssertEqual(tokens.count, 5, "should be equal")
    }
    
    func testJSONParserNumbersAndStrings() {
        let input = "[ 10, \"20\", 30, 40, 50, \"sdf\"]"
        var lexer = JSONLexer(input: input)
        let tokens = try! lexer.lex()
        XCTAssertEqual(tokens.count, 6, "should be equal")
    }
    
    func testJSONParserNumbersAndStringsAndBools() {
        let input = "[ false, 10, \"2.0\", 30, 4.0, 50, \"sdf\"]"
        var lexer = JSONLexer(input: input)
        let tokens = try! lexer.lex()
        print(tokens)
        XCTAssertEqual(tokens.count, 7, "should be equal")
    }
}
