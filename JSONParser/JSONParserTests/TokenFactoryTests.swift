//
//  TokenGeneraterTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class TokenFactoryTests: XCTestCase {
    //Given
    var tokenFactory: TokenFactory!
    
    override func setUp() {
        //Given
        self.tokenFactory = TokenFactory()
    }
    
    func testCreateNumberToken() {
        //When
        let input = "1"
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.Number(1))
    }
    
    func testCreateBoolToken() {
        //When
        let input = "true"
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.Bool(true))
    }
    
    func testCreateValueToken() {
        //When
        let input = "Hello"
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.Value("Hello"))
    }
    
    func testCreateWhiteSpaceToken() {
        //When
        let input = " "
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.WhiteSpace)
    }
    
    func testCreateCommaToken() {
        //When
        let input = ","
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.Comma)
    }
    
    func testCreateDoubleQuotationToken() {
        //When
        let input = "\"string\""
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.String("string"))
    }
    
    func testCreateLeftBraketToken() {
        //When
        let input = "["
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.LeftBraket)
    }
    
    func testCreateRightBraketToken() {
        //When
        let input = "]"
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.RightBraket)
    }
    
    func testCreateRightBraceToken() {
        //When
        let input = "}"
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.RightBrace)
    }
    
    func testCreateLeftBraceToken() {
        //When
        let input = "{"
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.LeftBrace)
    }
    
    func testCreateColonToken() {
        //When
        let input = ":"
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.Colon)
    }
}
