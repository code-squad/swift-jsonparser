//
//  TokenizerTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class TokenizerTests: XCTestCase {
    //GIVEN
    let input = "[ 24, \"Hello, JIEUN!\", 5, \"513\", 96, \"Bye, ogi!\", false ]"
    var tokenizer: Tokenizer!
    var tokens: [Token]!
    
    override func setUp() {
        //WHEN
        self.tokenizer = MyTokenizer(json: input)
        tokens = try! tokenizer.tokenize()
    }
    
    func testTokensCount(){
        //THEN
        XCTAssertEqual(tokens.count, 23)
    }
}
