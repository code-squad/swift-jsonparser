//
//  TokenizerUnitTest.swift
//  TokenizerUnitTest
//
//  Created by JH on 22/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class TokenizerUnitTest: XCTestCase {

    func testStandardInput() {
        var tokenizer = Tokenizer()
        let input = "[ 10 , \"Judy\" , true , 5 ]"
        let expectedResult = ["[","10",",","\"Judy\"",",","true",",","5","]"]
        XCTAssertEqual(tokenizer.tokenize(input: input), expectedResult)
    }
    
    func testManyWhitespacesInInput() {
        var tokenizer = Tokenizer()
        let input = "   [   10 , \"  Judy  \"   , true , 5        ]    "
        let expectedResult = ["[","10",",","\"  Judy  \"",",","true",",","5","]"]
        XCTAssertEqual(tokenizer.tokenize(input: input), expectedResult)
    }
    
    func testStructureInStringValues() {
        var tokenizer = Tokenizer()
        let input = "\"abc,ABC, [A,B,C]\""
        let expectedResult = ["\"abc,ABC, [A,B,C]\""]
        XCTAssertEqual(tokenizer.tokenize(input: input), expectedResult)
    }


}
