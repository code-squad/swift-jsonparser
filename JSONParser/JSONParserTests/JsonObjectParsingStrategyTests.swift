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
    var strategy: ParsingStrategy!
    
    let tokens = [JSONParser.Token.LeftBrace, JSONParser.Token.WhiteSpace, JSONParser.Token.DoubleQuotation, JSONParser.Token.Value("name"), JSONParser.Token.DoubleQuotation, JSONParser.Token.WhiteSpace, JSONParser.Token.Colon, JSONParser.Token.WhiteSpace, JSONParser.Token.DoubleQuotation, JSONParser.Token.Value("부엉이"), JSONParser.Token.DoubleQuotation, JSONParser.Token.WhiteSpace, JSONParser.Token.Comma, JSONParser.Token.WhiteSpace, JSONParser.Token.DoubleQuotation, JSONParser.Token.Value("age"), JSONParser.Token.DoubleQuotation, JSONParser.Token.WhiteSpace, JSONParser.Token.Colon, JSONParser.Token.WhiteSpace, JSONParser.Token.Number(27), JSONParser.Token.WhiteSpace, JSONParser.Token.Comma, JSONParser.Token.WhiteSpace, JSONParser.Token.DoubleQuotation, JSONParser.Token.Value("marreid"), JSONParser.Token.DoubleQuotation, JSONParser.Token.WhiteSpace, JSONParser.Token.Colon, JSONParser.Token.WhiteSpace, JSONParser.Token.Bool(false), JSONParser.Token.WhiteSpace, JSONParser.Token.RightBrace]
    //=======================================================
    // { "name" : "부엉이" , "age" : 27 , "marreid" : false }
    //=======================================================
   
    func testListParse() {
        //Given


    }
    func testObjectParse() {
        //Given
        self.strategy = JsonObjectParsingStrategy()

        //When
        let object = self.strategy.parse(tokens: <#[Token]#>)


        //Then

    
    }
}
