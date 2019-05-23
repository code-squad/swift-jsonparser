//
//  TokenGeneraterTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 23/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class TokenGeneraterTests: XCTestCase {

    func testCreateStringToken(){
        //GIVEN
        let token1 = TokenGenerater.createToken("\"hello, world!\"")
        let token2 = TokenGenerater.createToken("\"10\"")
        let token3 = TokenGenerater.createToken("\"true\"")
        //THEN
        XCTAssertEqual(token1.type, .String)
        XCTAssertEqual(token2.type, .String)
        XCTAssertEqual(token3.type, .String)
    }
    
    func testCreateNumberToken(){
        //GIVEN
        let token1 = TokenGenerater.createToken("-1")
        let token2 = TokenGenerater.createToken("10")
        let token3 = TokenGenerater.createToken("100")
        //THEN
        XCTAssertEqual(token1.type, .Number)
        XCTAssertEqual(token2.type, .Number)
        XCTAssertEqual(token3.type, .Number)
    }
    
    func testCreateArrayToken(){
        //GIVEN
        let token1 = TokenGenerater.createToken("[")
        let token2 = TokenGenerater.createToken("]")
        //THEN
        XCTAssertEqual(token1.type, .Array)
        XCTAssertEqual(token2.type, .Array)
    }
    
    func testCreateBoolToken(){
        //GIVEN
        let token1 = TokenGenerater.createToken("true")
        let token2 = TokenGenerater.createToken("false")
        //THEN
        XCTAssertEqual(token1.type, .Bool)
        XCTAssertEqual(token2.type, .Bool)
    }
}
