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
        XCTAssertEqual(token, Token.number(1))
    }
    
    func testCreateBoolToken() {
        //When
        let input = "true"
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.bool(true))
    }
  
    func testCreateWhiteSpaceToken() {
        //When
        let input = " "
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.ws)
    }
    
    func testCreateCommaToken() {
        //When
        let input = ","
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.comma)
    }
    
    func testCreateDoubleQuotationToken() {
        //When
        let input = "\"string\""
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.string("string"))
    }
    
    func testCreateLeftBraketToken() {
        //When
        let input = "["
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.leftBraket)
    }
    
    func testCreateRightBraketToken() {
        //When
        let input = "]"
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.rightBraket)
    }
    
    func testCreateRightBraceToken() {
        //When
        let input = "}"
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.rightBrace)
    }
    
    func testCreateLeftBraceToken() {
        //When
        let input = "{"
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.leftBrace)
    }
    
    func testCreateColonToken() {
        //When
        let input = ":"
        let token = self.tokenFactory.create(string: input)
        
        //Then
        XCTAssertEqual(token, Token.colon)
    }
}
