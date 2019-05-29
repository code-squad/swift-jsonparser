//
//  ParserTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class JSONListParserTests: XCTestCase {
    //Given
    var strategy: JSONListParseStrategy!
    let jsonListTokens: Array<Token> =
        [.LeftBraket,
         .WhiteSpace, .Number(10), .Comma,
         .WhiteSpace, .String("\"Hello, World\""), .Comma,
         .WhiteSpace, .Bool(true), .Comma,
         .WhiteSpace, .String("\"314\""), .WhiteSpace,
         .RightBraket]
    // [ 10, "Hello, World", true, "314" ]
    let jsonObjectTokens: Array<Token> =
        [Token.LeftBrace, Token.WhiteSpace, Token.DoubleQuotation, Token.Value("name"), Token.DoubleQuotation, Token.WhiteSpace, Token.Colon, Token.WhiteSpace, Token.DoubleQuotation, Token.Value("KIM"), Token.WhiteSpace, Token.Value("JUNG"), Token.DoubleQuotation, Token.Comma, Token.WhiteSpace, Token.DoubleQuotation, Token.Value("alias"), Token.DoubleQuotation, Token.WhiteSpace, Token.Colon, Token.WhiteSpace, Token.DoubleQuotation, Token.Value("JK"), Token.DoubleQuotation, Token.WhiteSpace, Token.Comma, Token.WhiteSpace, Token.DoubleQuotation, Token.Value("level"), Token.DoubleQuotation, Token.WhiteSpace, Token.Colon, Token.WhiteSpace, Token.Number(5), Token.Comma, Token.WhiteSpace, Token.DoubleQuotation, Token.Value("married"), Token.DoubleQuotation, Token.WhiteSpace, Token.Colon, Token.WhiteSpace, Token.Bool(true), Token.WhiteSpace, Token.RightBrace]
    //{ "name" : "KIM JUNG", "alias" : "JK" , "level" : 5, "married" : true }
    
    func testListParse() {
        //Given

        
    }
    func testObjectParse() {
        //Given
        self.strategy = JSONObjectParseStrategy()
        
        //When
        let object = self.strategy?.parse()
        
        
        //Then
        
        
    }
}
