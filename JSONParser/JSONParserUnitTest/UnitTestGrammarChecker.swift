//
//  UnitTestGrammarChecker.swift
//  JSONParserUnitTest
//
//  Created by 윤지영 on 29/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest

class UnitTestGrammarChecker: XCTestCase {

    func testIsValid_whenObjectHasRightGrammar() {
        let jsonObject = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertTrue(GrammarChecker.isValid(jsonObject, for: JSONRegex.jsonObject))
    }

    func testIsNotValid_whenObjectHasNoColon() {
        let jsonObject = "{ \"name\" \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertFalse(GrammarChecker.isValid(jsonObject, for: JSONRegex.jsonObject))
    }

    func testIsNotValid_whenObjectHasNoComma() {
        let jsonObject = "{ \"name\" : \"KIM JUNG\" \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertFalse(GrammarChecker.isValid(jsonObject, for: JSONRegex.jsonObject))
    }

    func testIsNotValid_whenObjectHasNothing() {
        let jsonObject = "{  }"
        XCTAssertFalse(GrammarChecker.isValid(jsonObject, for: JSONRegex.jsonObject))
    }

    func testIsNotValid_whenObjectKeyHasNoQuotation() {
        let jsonObject = "{ \"name\" : \"KIM JUNG\", alias : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertFalse(GrammarChecker.isValid(jsonObject, for: JSONRegex.jsonObject))
    }

    func testIsValid_whenObjectHasNestedArray() {
        let jsonObject = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true, \"array\" : [ \"nested\" ] }"
        XCTAssertTrue(GrammarChecker.isValid(jsonObject, for: JSONRegex.jsonObject))
    }
    
    func testIsNotValid_whenObjectHasDoubleNestedArray() {
        let jsonObject = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true, \"array\" : [ \"nested\", [\"doubleNested\", true] ] }"
        XCTAssertFalse(GrammarChecker.isValid(jsonObject, for: JSONRegex.jsonObject))
    }

    func testIsValid_whenArrayHasRightGrammar() {
        let jsonArray = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
        XCTAssertTrue(GrammarChecker.isValid(jsonArray, for: JSONRegex.jsonArray))
    }

    func testIsNotValid_whenArrayHasNotCompleteSquareBracket() {
        let jsonArray = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } "
        XCTAssertFalse(GrammarChecker.isValid(jsonArray, for: JSONRegex.jsonArray))
    }

    func testIsNotValid_whenArrayHasNotCompleteCurlyBracket() {
        let jsonArray = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true , { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
        XCTAssertFalse(GrammarChecker.isValid(jsonArray, for: JSONRegex.jsonArray))
    }

    func testIsValid_whenArrayHasNestedArray() {
        let jsonArray = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true }, [ \"nested\" ] ]"
        XCTAssertTrue(GrammarChecker.isValid(jsonArray, for: JSONRegex.jsonArray))
    }
    
    func testIsNotValid_whenArrayHasDoubleNestedArray() {
        let jsonArray = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true }, [ \"nested\", [true, false] ] ]"
        XCTAssertFalse(GrammarChecker.isValid(jsonArray, for: JSONRegex.jsonArray))
    }

}
