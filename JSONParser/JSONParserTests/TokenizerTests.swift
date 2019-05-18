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
    let tokenizer:Tokenizer = MyTokenizer()
    
    func testTokenize(){
        //GIVEN
        let target = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false , \"Hello, World!\" ]"
        //WHEN
        let tokens = self.tokenizer.tokenize(target)
        //THEN
        XCTAssertEqual(tokens.count, 8)
    }
    
    //======================================
    //               NUMBER
    //======================================
    
    func testTokenizeTypeCheckNumberSuccess(){
        //GIVEN
        let target = "[ 10, -4, 100 ]"
        let tokens = self.tokenizer.tokenize(target)
        //THEN
        XCTAssertEqual(tokens.count, 3)
        _ = tokens.map{ XCTAssertEqual($0.type,Type.Number) }
    }
    
    func testTokenizeTypeCheckNumberFalse(){
        //GIVEN
        let target = "[ \"실패\", true, \"100\" ]"
        let tokens = self.tokenizer.tokenize(target)
        //THEN
        XCTAssertEqual(tokens.count, 3)
        _ = tokens.map{ XCTAssertNotEqual($0.type,Type.Number) }
    }
    
    //======================================
    //               String
    //======================================
    
    func testTokenizeTypeCheckStringSuccess(){
        //GIVEN
        let target = "[ \"10\", \"true\", \"hello, world\" ]"
        let tokens = self.tokenizer.tokenize(target)
        //THEN
        XCTAssertEqual(tokens.count, 3)
        _ = tokens.map{ XCTAssertEqual($0.type,Type.String) }
    }
    
    func testTokenizeTypeCheckStringFalse(){
        //GIVEN
        let target = "[ 실패, true, 100 ]"
        let tokens = self.tokenizer.tokenize(target)
        //THEN
        XCTAssertEqual(tokens.count, 3)
        _ = tokens.map{ XCTAssertNotEqual($0.type,Type.String) }
    }
    
    //======================================
    //               Bool
    //======================================
    
    func testTokenizeTypeCheckBoolSuccess(){
        //GIVEN
        let target = "[ true, false ]"
        let tokens = self.tokenizer.tokenize(target)
        //THEN
        XCTAssertEqual(tokens.count, 3)
        _ = tokens.map{ XCTAssertEqual($0.type,Type.Bool) }
    }
    
    func testTokenizeTypeCheckBoolFalse(){
        //GIVEN
        let target = "[ \"실패\", \"true\", \"false\", \"100\" ]"
        let tokens = self.tokenizer.tokenize(target)
        //THEN
        XCTAssertEqual(tokens.count, 4)
        _ = tokens.map{ XCTAssertNotEqual($0.type,Type.Bool) }
    }

}
