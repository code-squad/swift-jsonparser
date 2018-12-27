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
        let validData = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertTrue(Parser.isDivideData(from: validData))
    }
    // Open Bracket X
    func testParserisNoOpenBracket() {
        let noOpenBracket = " \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertFalse(Parser.isDivideData(from: noOpenBracket))
    }
    // Close Bracket X
    func testParserisNoCloseBracket() {
        let noCloseBracket = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true "
        XCTAssertFalse(Parser.isDivideData(from: noCloseBracket))
    }
    
    //Array Valid Data
    func testArrayParserisValidData() {
        let validData = "[{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true },{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }]"
        XCTAssertTrue(Parser.isDivideData(from: validData))
    }

}
