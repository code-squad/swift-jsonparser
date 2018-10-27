//
//  JSONParserUnitTest.swift
//  JSONParserUnitTest
//
//  Created by 윤지영 on 19/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest

class UnitTestJSONParser: XCTestCase {

    func testParseNil_whenColonNotIncludedProperlyInJSONObject() {
        let jsonString = "{ \"name\"  \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertNil(JSONParser.parse(jsonString))
    }

    func testParseNil_whenKeyValueNotSatisfiedInJSONObject() {
        let jsonString = "{ \"name\" : \"KIM JUNG\",:, \"level\" : 5, \"married\" : true }"
        XCTAssertNil(JSONParser.parse(jsonString))
    }

    func testParseNil_whenKeyHasNoDoubleQuotationInJSONObject() {
        let jsonString = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, married : true }"
        XCTAssertNil(JSONParser.parse(jsonString))
    }

    func testParseNil_whenNoSideCurlyBracket() {
        let jsonString = "\"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, married : true"
        XCTAssertNil(JSONParser.parse(jsonString))
    }

    func testParseNil_whenNoSideSquareBracket() {
        let jsonString = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, married : true }, { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, married : true }"
        XCTAssertNil(JSONParser.parse(jsonString))
    }

}
