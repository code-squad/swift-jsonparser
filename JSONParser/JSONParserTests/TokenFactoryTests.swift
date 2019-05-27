//
//  TokenGeneraterTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class TokenFactoryTests: XCTestCase {
    //GIVEN
    var tokenFactory: TokenFactory!
    
    override func setUp() {
        //GIVEN
        self.tokenFactory = MyTokenFactory()
    }
    
    func testCreateNumberToken(){
        //WHEN
        let input = "1"
        let token = self.tokenFactory.createToken(string: input)
        //THEN
        XCTAssertEqual(token, Token.Number(1))
    }
    
    func testCreateBoolToken(){
        //WHEN
        let input = "true"
        let token = self.tokenFactory.createToken(string: input)
        //THEN
        XCTAssertEqual(token, Token.Bool(true))
    }
    
    func testCreateStringToken(){
        //WHEN
        let input = "\"Hello, World!\""
        let token = self.tokenFactory.createToken(string: input)
        //THEN
        XCTAssertEqual(token, Token.String("Hello, World!"))
    }
    
    func testCreateCommaToken(){
        //WHEN
        let input = ","
        let token = self.tokenFactory.createToken(string: input)
        //THEN
        XCTAssertEqual(token, Token.Comma)
    }
    
    func testCreateWhiteSpaceToken(){
        //WHEN
        let input = " "
        let token = self.tokenFactory.createToken(string: input)
        //THEN
        XCTAssertEqual(token, Token.WhiteSpace)
    }
    
}
