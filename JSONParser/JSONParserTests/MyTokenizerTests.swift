//
//  TokenizerTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class MyTokenizerTests: XCTestCase {
    //GIVEN
    let input = "[ 24, \"Hello, World\", \"513\", false ]"
    var tokenizer: Tokenizer!
    var tokens: [Token]!
    
    override func setUp() {
        //WHEN
        self.tokenizer = MyTokenizer(input)
        self.tokens = try! tokenizer.tokenize()
    }
    
    func testTokensCount() { 
        //THEN
        XCTAssertEqual(tokens.count, 21)
    }
}
