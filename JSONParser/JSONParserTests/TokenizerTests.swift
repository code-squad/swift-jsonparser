//
//  TokenizerTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class TokenizerTests: XCTestCase {

    func testTokenize(){
        
        //GIVEN
        var tokenizer: Tokenizer = MyTokenizer(string: "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false , \"Hello, World!\" ]")
        
        //WHEN
        let tokens = try! tokenizer.tokenize()
        //THEN
        XCTAssertEqual(tokens.count, 8)
    }
    
    //======================================
    //               NUMBER
    //======================================
    
    func testTokenizeTypeCheckNumberSuccess(){
        //GIVEN
        var tokenizer: Tokenizer = MyTokenizer(string: "[ 10, -4, 100 ]")
        //WHEN
        let tokens = try! tokenizer.tokenize()
        //THEN
        XCTAssertEqual(tokens.count, 3)
        _ = tokens.map{ XCTAssertEqual($0.type,TokenType.Number) }
    }
    
    func testTokenizeTypeCheckNumberFalse(){
        //GIVEN
        var tokenizer: Tokenizer = MyTokenizer(string: "[ \"실패\", true, \"100\" ]")
        //WHEN
        let tokens = try! tokenizer.tokenize()
        //THEN
        XCTAssertEqual(tokens.count, 3)
        _ = tokens.map{ XCTAssertEqual($0.type,TokenType.Number) }
    }
    
    //======================================
    //               String
    //======================================
    
    func testTokenizeTypeCheckStringSuccess(){
        //GIVEN
        var tokenizer: Tokenizer = MyTokenizer(string: "[ \"10\", \"true\", \"hello, world\" ]")
        //WHEN
        let tokens = try! tokenizer.tokenize()
        //THEN
        XCTAssertEqual(tokens.count, 3)
        _ = tokens.map{ XCTAssertEqual($0.type,TokenType.String) }
    }
    
    func testTokenizeTypeCheckStringFalse(){
        //GIVEN
        var tokenizer: Tokenizer = MyTokenizer(string: "[ 실패, true, 100 ]")
        //WHEN
        let tokens = try! tokenizer.tokenize()
        //THEN
        XCTAssertEqual(tokens.count, 3)
        _ = tokens.map{ XCTAssertEqual($0.type,TokenType.String) }
    }
    
    //======================================
    //               Bool
    //======================================
    
    func testTokenizeTypeCheckBoolSuccess(){
        //GIVEN
        var tokenizer: Tokenizer = MyTokenizer(string: "[ true, false ]")
        //WHEN
        let tokens = try! tokenizer.tokenize()
        //THEN
        XCTAssertEqual(tokens.count, 3)
        _ = tokens.map{ XCTAssertEqual($0.type,TokenType.Bool) }
    }
    
    func testTokenizeTypeCheckBoolFalse(){
        //GIVEN
        var tokenizer: Tokenizer = MyTokenizer(string: "[ \"실패\", \"true\", \"false\", \"100\" ]")
        //WHEN
        let tokens = try! tokenizer.tokenize()
        //THEN
        XCTAssertEqual(tokens.count, 4)
        _ = tokens.map{ XCTAssertEqual($0.type,TokenType.Bool) }
    }

}
