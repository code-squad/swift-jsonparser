//
//  ParserTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class JsonObjectParsingStrategyTests: XCTestCase {
    //Given
    var strategy: JsonParsingStrategy!
    
    var tokens: [Token] = [.leftBrace,
                  .ws, .string("name"), .ws, .colon, .ws, .string("부엉이"), .comma,
                  .ws, .string("age"),.ws, .colon, .ws, .number(27), .comma,
                  .ws, .string("married"),.ws, .colon, .ws, .bool(false), .ws, .rightBrace]
    //=======================================================
    // { "name":"부엉이", "age" : 27, "married" : false }
    //=======================================================
    
    override func setUp() {
        //Given
        self.strategy = JsonObjectParsingStrategy(converter: TokenConverter())
    }
    
    func testObjectParse() {
        //Given
        let expected: JsonObject = ["name":"부엉이", "age" : 27, "married" : false]
        
        //When
        let object : JsonObject = self.strategy.parse(tokens: self.tokens,parsedIndex: 0).value as! JsonObject
        
        let name = object["name"]?.getJsonValue()
        let age = object["age"]?.getJsonValue()
        let married = object["married"]?.getJsonValue()
        //Then
        XCTAssertEqual(expected["name"]!.getJsonValue(), name)
        XCTAssertEqual(expected["age"]!.getJsonValue(), age )
        XCTAssertEqual(expected["married"]!.getJsonValue(), married)
        
    }
}
