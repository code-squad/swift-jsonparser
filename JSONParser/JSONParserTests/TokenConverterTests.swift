//
//  JsonValueFactoryTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 30/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class TokenConverterTests: XCTestCase {
    //Given
    let tokenConverter = TokenConverter()
    
    
    func testConvertStringJsonValue() {
        //Given
        let tokenString = Token.String("\"Hello, World\"")
        
        //When
        let jsonValue = tokenConverter.convert(before: tokenString)
        
        //Then
        XCTAssertEqual(jsonValue!.getJsonValue(), "\"Hello, World\"")
    }
    
    func testConvertNumberJsonValue() {
        //Given
        let tokenNumber = Token.Number(3)
        
        //When
        let jsonValue = tokenConverter.convert(before: tokenNumber)
        //Then
        XCTAssertEqual(jsonValue!.getJsonValue(), "3")
    }
    
    func testConvertJsonValue() {
        //Given
        let tokenBool = Token.Bool(true)
        
        //When
        let jsonValue = tokenConverter.convert(before: tokenBool)
        
        //Then
        XCTAssertEqual(jsonValue!.getJsonValue(), "true")
        
    }
    
}
