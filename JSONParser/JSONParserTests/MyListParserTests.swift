//
//  ParserTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class MyListParserTests: XCTestCase {
    //Given
    var listParser: Parser!
    let tokens: Array<Token> =
        [.LeftBraket,
         .WhiteSpace, .Number, .Comma,
         .WhiteSpace, .String, .Comma,
         .WhiteSpace, .Bool, .Comma,
         .WhiteSpace, .String, .WhiteSpace,
         .RightBraket]
    // [ 10, "Hello, World", true, "314" ]
    
    override func setUp() {
        //Given
        self.listParser = MyListParser(tokens: tokens)
    }
    
    func testParse() {
        //When
        let result = self.listParser.parse()
        var dic = Dictionary<Token, Int>()
        dic[.Number] = 1
        dic[.String] = 2
        dic[.Bool] = 1
        
        //Then
        XCTAssertEqual(dic, result)
    }
}
