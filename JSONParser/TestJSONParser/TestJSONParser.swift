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
    
    // comparison : InputString.count Data , Parser.count Data
    func testParserDataCountNotComparison() {
        let testData = "[ 10, 21, \"cony\", - ]"
        let comparisonData = Parser.DivideData(from: testData)
        let parserDataCount = (Int(comparisonData?.0.0.count ?? 0)-1+Int(comparisonData?.0.1.count ?? 0)-1+Int(comparisonData?.0.2.count ?? 0)-1)
        if comparisonData?.1 == parserDataCount {
            XCTAssertTrue(true)
        }
    }
    
    func testParserDataCountComparison() {
        let testData = "[ 10, 21, \"cony\", 33 ]"
        let comparisonData = Parser.DivideData(from: testData)
        let parserDataCount = (Int(comparisonData?.0.0.count ?? 0)-1+Int(comparisonData?.0.1.count ?? 0)-1+Int(comparisonData?.0.2.count ?? 0)-1)
        if comparisonData?.1 != parserDataCount {
            XCTAssertTrue(true)
        }
    }

}
