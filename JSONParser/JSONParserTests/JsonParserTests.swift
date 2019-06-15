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
        [.LeftBraket,
         .WhiteSpace, .Number(10), .Comma,
         .WhiteSpace, .String("Hello, World"), .Comma,
         .WhiteSpace, .Bool(true), .Comma,
         .WhiteSpace, .String("314"), .WhiteSpace,
         .RightBraket]
    //=======================================
    //  [ 10, "Hello, World", true, "314" ]
    //=======================================
    var jsonObjectTokens: [Token] =
        [.LeftBrace,
         .WhiteSpace,
         .String("name"),
         .WhiteSpace, .Colon, .WhiteSpace,
         .String("부엉이"), .Comma,
         .WhiteSpace,
         .String("age"),
         .WhiteSpace, .Colon, .WhiteSpace,
         .Number(27), .Comma,
         .WhiteSpace,
         .String("married"),
         .WhiteSpace, .Colon, .WhiteSpace,
         .Bool(false), .WhiteSpace,
         .RightBrace]
    //=======================================================
    // { "name":"부엉이", "age" : 27, "married" : false }
    //=======================================================

    func testParsingList() {
        //Given
        self.parser = JsonParser.init()
        
        //When
        let jsonList = self.parser.parse(tokens: &jsonListTokens) as! JsonList
        
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
        let jsonObject = self.parser.parse(tokens: &self.jsonObjectTokens) as! JsonObject
        
        //Then
        XCTAssertEqual(jsonObject["name"]!.getJsonValue(),"부엉이")
        XCTAssertEqual(jsonObject["age"]!.getJsonValue(),"27")
        XCTAssertEqual(jsonObject["married"]!.getJsonValue(),"false")
    }
    
    
    
}
