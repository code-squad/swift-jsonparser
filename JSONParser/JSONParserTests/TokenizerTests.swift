//
//  TokenizerTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class TokenizerTests: XCTestCase {

    //GIVEN
    var tokenizer:Tokenizer = MyTokenizer()
    
    func testTokenize(){
        //GIVEN
        let target = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false , \"Hello, World!\" ]"
        //WHEN
        let tokens = try! self.tokenizer.tokenize(target)
        //THEN
        XCTAssertEqual(tokens.count, 8)
    }
    
    //======================================
    //               NUMBER
    //======================================
    
    func testTokenizeTypeCheckNumberSuccess(){
        //GIVEN
        let target = "[ 10, -4, 100 ]"
        let tokens = try! self.tokenizer.tokenize(target)
        //THEN
        XCTAssertEqual(tokens.count, 3)
        _ = tokens.map{ XCTAssertEqual($0.type,TokenType.Number) }
    }
    
    func testTokenizeTypeCheckNumberFalse(){
        //GIVEN
        let target = "[ \"실패\", true, \"100\" ]"
        let tokens = try! self.tokenizer.tokenize(target)
        //THEN
        XCTAssertEqual(tokens.count, 3)
        _ = tokens.map{ XCTAssertNotEqual($0.type,TokenType.Number) }
    }
    
    //======================================
    //               String
    //======================================
    
    func testTokenizeTypeCheckStringSuccess(){
        //GIVEN
        let target = "[ \"10\", \"true\", \"hello, world\" ]"
        let tokens = try! self.tokenizer.tokenize(target)
        //THEN
        XCTAssertEqual(tokens.count, 3)
        _ = tokens.map{ XCTAssertEqual($0.type,TokenType.String) }
    }
    
    func testTokenizeTypeCheckStringFalse(){
        //GIVEN
        let target = "[ 실패, true, 100 ]"
        let tokens = try! self.tokenizer.tokenize(target)
        //THEN
        XCTAssertEqual(tokens.count, 3)
        _ = tokens.map{ XCTAssertNotEqual($0.type,TokenType.String) }
    }
    
    //======================================
    //               Bool
    //======================================
    
    func testTokenizeTypeCheckBoolSuccess(){
        //GIVEN
        let target = "[ true, false ]"
        let tokens = try! self.tokenizer.tokenize(target)
        //THEN
        XCTAssertEqual(tokens.count, 3)
        _ = tokens.map{ XCTAssertEqual($0.type,TokenType.Bool) }
    }
    
    func testTokenizeTypeCheckBoolFalse(){
        //GIVEN
        let target = "[ \"실패\", \"true\", \"false\", \"100\" ]"
        let tokens = try! self.tokenizer.tokenize(target)
        //THEN
        XCTAssertEqual(tokens.count, 4)
        _ = tokens.map{ XCTAssertNotEqual($0.type,TokenType.Bool) }
    }

}
