//
//  JsonListParsingStrategy.swift
//  JSONParserTests
//
//  Created by 이동영 on 31/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class JsonListParsingStrategy: XCTestCase {
    //Given
    let strategy: JsonParsingStrategy!
    
    let jsonListTokens: Array<Token> =
        [.LeftBraket,
         .WhiteSpace, .Number(10), .Comma,
         .WhiteSpace, .String("\"Hello, World\""), .Comma,
         .WhiteSpace, .Bool(true), .Comma,
         .WhiteSpace, .String("\"314\""), .WhiteSpace,
         .RightBraket]
    //=======================================
    //  [ 10, "Hello, World", true, "314" ]
    //=======================================
    
    
    let strategy = JsonListParsingStrategy
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }


}
