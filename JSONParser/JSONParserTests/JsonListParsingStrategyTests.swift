//
//  JsonListParsingStrategy.swift
//  JSONParserTests
//
//  Created by 이동영 on 31/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class JsonListParsingStrategyTests: XCTestCase {
    //Given
    var strategy: JsonParsingStrategy!
    
    var tokens: [Token] =
        [.leftBraket,
         .ws, .number(10), .comma,
         .ws, .string("Hello, World"), .comma,
         .ws, .bool(true), .comma,
         .ws, .string("314"), .ws,
         .rightBraket]
    //=======================================
    //  [ 10, "Hello, World", true, "314" ]
    //=======================================
    
    override func setUp() {
        //Given
        self.strategy = JsonListParsingStrategy(converter: TokenConverter())
    }
    
    func testListParse() {
        //Given
        let expected: JsonList = [10,"Hello, World",true,"314"]
        
        //When
        let jsonList: JsonList = self.strategy.parse(tokens: self.tokens,parsedIndex: 0).value as! JsonList
        
        //Then
        XCTAssertEqual(expected.count,jsonList.count)
        XCTAssertEqual(expected[0].getJsonValue(), jsonList[0].getJsonValue())
        XCTAssertEqual(expected[1].getJsonValue(), jsonList[1].getJsonValue())
        XCTAssertEqual(expected[2].getJsonValue(), jsonList[2].getJsonValue())
        XCTAssertEqual(expected[3].getJsonValue(), jsonList[3].getJsonValue())
        
    }
    
}
