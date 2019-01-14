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
    func testParserisValidDataJSONObject() {
        let validData = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertNotNil(Parser.divideData(validData))
    }
    
    // Open Bracket X
    func testParserisNoOpenBracket() {
        let noOpenBracket = " \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertNil(Parser.divideData(noOpenBracket))
    }
    
    // Close Bracket X
    func testParserisNoCloseBracket() {
        let noCloseBracket = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true "
        XCTAssertNil(Parser.divideData(noCloseBracket))
    }
    
    //GrammarChecker
    //jsonObject validData O
    func testGrammarCheckerValidDataJsonObject() {
        let validData = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertTrue(GrammarChecker.regexTest(pattern: GrammarChecker.jsonObject)(validData))
    }
        
    //jsonArray validData O
    func testGrammarCheckerValidDataJsonArray() {
        let validData = "[{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true },{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }]"
        XCTAssertTrue(GrammarChecker.regexTest(pattern: GrammarChecker.jsonArray)(validData))
    }
        
    //jsonObject validData x
    func testGrammarCheckerNotValidDataJsonObject() {
        let validData = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertFalse(GrammarChecker.regexTest(pattern: GrammarChecker.jsonArray)(validData))
    }
        
    //jsonArray validData x
    func testGrammarCheckerNotValidDataJsonArray() {
        let validData = "[{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true },{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }]"
        XCTAssertFalse(GrammarChecker.regexTest(pattern: GrammarChecker.jsonObject)(validData))
    }
    //jsonObject No Colon
    func testGrammarCheckerNotColonDataJsonObject() {
        let validData = "[{ \"name\"  \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true },{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }]"
        XCTAssertFalse(GrammarChecker.regexTest(pattern: GrammarChecker.jsonObject)(validData))
    }
    //jsonObject No comma
    func testGrammarCheckerNotCommaDataJsonObject() {
        let validData = "[{ \"name\" : \"KIM JUNG\" \"alias\" : \"JK\", \"level\" : 5, \"married\" : true },{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }]"
        XCTAssertFalse(GrammarChecker.regexTest(pattern: GrammarChecker.jsonObject)(validData))
    }
    //jsonObject No Data
    func testGrammarCheckerNilDataJsonObject() {
        let validData = " "
        XCTAssertFalse(GrammarChecker.regexTest(pattern: GrammarChecker.jsonObject)(validData))
    }
    //jsonObject No QuotationMarks
    func testGrammarCheckerNotQuotationMarksDataJsonObject() {
        let validData = "[{ name : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true },{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }]"
        XCTAssertFalse(GrammarChecker.regexTest(pattern: GrammarChecker.jsonObject)(validData))
    }
    //jsonObject Data Array
    func testGrammarCheckerArrayDataJsonObject() {
        let validData = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        XCTAssertTrue(GrammarChecker.regexTest(pattern: GrammarChecker.jsonObject)(validData))
    }
    //jsonObject Data DoubleArray Not ValidData
    func testGrammarCheckerDoubleArrayDataJsonObject() {
        let validData = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\",[\"hana\", \"hayul\", \"haun\"] ,\"hayul\", \"haun\"] }"
        XCTAssertFalse(GrammarChecker.regexTest(pattern: GrammarChecker.jsonObject)(validData))
    }
    //jsonArray validData No Bracket
    func testGrammarCheckerNoBracketDataJsonArray() {
        let validData = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true },{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertFalse(GrammarChecker.regexTest(pattern: GrammarChecker.jsonArray)(validData))
    }
    //jsonArray validData No BigBracket
    func testGrammarCheckerNoBigBracketDataJsonArray() {
        let validData = "[ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true },{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true ]"
        XCTAssertFalse(GrammarChecker.regexTest(pattern: GrammarChecker.jsonArray)(validData))
    }
    //jsonArray ManyArray validData O
    func testGrammarCheckerManyArrayJsonArray() {
        let validData = "[{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true },{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true },{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }]"
        XCTAssertTrue(GrammarChecker.regexTest(pattern: GrammarChecker.jsonArray)(validData))
    }
    //jsonArray Key -> Array Data
    func testGrammarCheckerKeyArrayJsonArray() {
        let validData = "[{ [\"hana\", \"hayul\", \"haun\"] : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true },{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }]"
        XCTAssertFalse(GrammarChecker.regexTest(pattern: GrammarChecker.jsonArray)(validData))
    }
    //jsonArray nil Data
    func testGrammarCheckerNilDataJsonArray() {
        let validData = " "
        XCTAssertFalse(GrammarChecker.regexTest(pattern: GrammarChecker.jsonArray)(validData))
    }
    
}
