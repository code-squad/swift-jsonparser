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
    
    let tokens = [Token.LeftBrace,
                  Token.WhiteSpace, Token.String("name"), Token.WhiteSpace, Token.Colon, Token.WhiteSpace, Token.String("부엉이"), Token.Comma,
                  Token.WhiteSpace, Token.String("age"),Token.WhiteSpace, Token.Colon, Token.WhiteSpace, Token.Number(27), Token.Comma,
                  Token.WhiteSpace, Token.String("married"),Token.WhiteSpace, Token.Colon, Token.WhiteSpace, Token.Bool(false), Token.WhiteSpace, Token.RightBrace]
    //=======================================================
    // { "name":"부엉이", "age" : 27, "married" : false }
    //=======================================================
    
    override func setUp() {
        //Given
        self.strategy = JsonObjectParsingStrategy()
    }
    
    func testObjectParse() {
        //Given
        let expected: JsonObject = ["name":"부엉이", "age" : 27, "married" : false]
        
        //When
        let object : JsonObject = self.strategy.parse(tokens: self.tokens) as! JsonObject
        
        //Then
        XCTAssertEqual(expected["name"]!.getJsonValue(), object["name"]!.getJsonValue())
        XCTAssertEqual(expected["age"]!.getJsonValue(), object["age"]!.getJsonValue())
        XCTAssertEqual(expected["married"]!.getJsonValue(), object["married"]!.getJsonValue())
        
    }
}
