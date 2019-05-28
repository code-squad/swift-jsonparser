//
//  TokenGeneraterTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class MyTokenFactoryTests: XCTestCase {
    //GIVEN
    var tokenFactory: TokenFactory!
    
    override func setUp() {
        //GIVEN
        self.tokenFactory = MyTokenFactory()
    }
    
    func testCreateNumberToken() {
        //WHEN
        let input = "1"
        let token = self.tokenFactory.createToken(string: input)
        
        //THEN
        XCTAssertEqual(token, Token.Number)
    }
    
    func testCreateBoolToken() {
        //WHEN
        let input = "true"
        let token = self.tokenFactory.createToken(string: input)
        
        //THEN
        XCTAssertEqual(token, Token.Bool)
    }
    
    func testCreateValueToken() {
        //WHEN
        let input = "Hello"
        let token = self.tokenFactory.createToken(string: input)
        
        //THEN
        XCTAssertEqual(token, Token.Value)
    }
    
    func testCreateWhiteSpaceToken() {
        //WHEN
        let input = " "
        let token = self.tokenFactory.createToken(string: input)
        
        //THEN
        XCTAssertEqual(token, Token.WhiteSpace)
    }
    
    func testCreateCommaToken() {
        //WHEN
        let input = ","
        let token = self.tokenFactory.createToken(string: input)
        
        //THEN
        XCTAssertEqual(token, Token.Comma)
    }
    
    func testCreateDoubleQuotationToken() {
        //WHEN
        let input = "\""
        let token = self.tokenFactory.createToken(string: input)
        
        //THEN
        XCTAssertEqual(token, Token.DoubleQuotation)
    }
    
    func testCreateLeftBraketToken() {
        //WHEN
        let input = "["
        let token = self.tokenFactory.createToken(string: input)
        
        //THEN
        XCTAssertEqual(token, Token.LeftBraket)
    }
    
    func testCreateRightBraketToken() {
        //WHEN
        let input = "]"
        let token = self.tokenFactory.createToken(string: input)
        
        //THEN
        XCTAssertEqual(token, Token.RightBraket)
    }
}
