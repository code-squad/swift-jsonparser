//
//  JsonParserTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 31/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class JsonParserTests: XCTestCase {
    //Given
    var parser: JsonParser!
    var jsonListTokens: [Token] =
        [.leftBraket,
         .ws, .number(10), .comma,
         .ws, .string("Hello, World"), .comma,
         .ws, .bool(true), .comma,
         .ws, .string("314"), .ws,
         .rightBraket]
    //=======================================
    //  [ 10, "Hello, World", true, "314" ]
    //=======================================
    var jsonObjectTokens: [Token] =
        [.leftBrace,
         .ws,
         .string("name"),
         .ws, .colon, .ws,
         .string("부엉이"), .comma,
         .ws,
         .string("age"),
         .ws, .colon, .ws,
         .number(27), .comma,
         .ws,
         .string("married"),
         .ws, .colon, .ws,
         .bool(false), .ws,
         .rightBrace]
    //=======================================================
    // { "name":"부엉이", "age" : 27, "married" : false }
    //=======================================================

    func testParsingList() {
        //Given
        self.parser = JsonParser.init()
        
        //When
        let jsonList = JsonParser.run(tokens: jsonListTokens, parsedIndex: 0).value as! JsonList
        
        //Then
        XCTAssertEqual(jsonList[0].getJsonValue(), String(10) )
        XCTAssertEqual(jsonList[1].getJsonValue(), "Hello, World")
        XCTAssertEqual(jsonList[2].getJsonValue(), String(true))
        XCTAssertEqual(jsonList[3].getJsonValue(), "314")
    }
    
    
    func testParsingObject() {
        //Given
        
        self.parser = JsonParser.init()
        
        //When
        let jsonObject = JsonParser.run(tokens: self.jsonObjectTokens).value as! JsonObject
        
        //Then
        XCTAssertEqual(jsonObject["name"]!.getJsonValue(),"부엉이")
        XCTAssertEqual(jsonObject["age"]!.getJsonValue(),"27")
        XCTAssertEqual(jsonObject["married"]!.getJsonValue(),"false")
    }
    
    
    
}
