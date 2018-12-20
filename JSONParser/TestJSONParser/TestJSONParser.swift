//
//  TestJSONParser.swift
//  TestJSONParser
//
//  Created by Elena on 20/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest
@testable import JSONParser

class TestJSONParser: XCTestCase {

    override func setUp() { }
    override func tearDown() { }

    //Parser
    // Valid Data
    func testParserisValidData() {
        let validData = "[ 10, 21, 4, 314, 99, 0, 72 ]"
        XCTAssertTrue(Parser.isDivideData(from: validData))
    }
    // Open Bracket X
    func testParserisNoOpenBracket() {
        let noOpenBracket = " 10, 21, 4, 314, 99, 0, 72 ]"
        XCTAssertFalse(Parser.isDivideData(from: noOpenBracket))
    }
    // Close Bracket X
    func testParserisNoCloseBracket() {
        let noCloseBracket = "[ 10, 21, 4, 314, 99, 0, 72"
        XCTAssertFalse(Parser.isDivideData(from: noCloseBracket))
    }
    

}
