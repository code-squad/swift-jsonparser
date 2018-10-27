//
//  UnitTestExtensions.swift
//  JSONParserUnitTest
//
//  Created by 윤지영 on 19/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest

class UnitTestExtensions: XCTestCase {

    func testHasNoSideSquareBracket() {
        let noSideSquareBracket = "10, \"jk\", 4, \"314\", 99, \"crong\""
        XCTAssertFalse(noSideSquareBracket.hasSideSquareBrackets())
    }

    func testHasOneSideSquartBracket() {
         let oneSideSquareBracket = "[10, \"jk\", 4, \"314\", 99, \"crong\""
        XCTAssertFalse(oneSideSquareBracket.hasSideSquareBrackets())
    }

    func testHasSideSquareBrackets() {
        let jsonString = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        XCTAssertTrue(jsonString.hasSideSquareBrackets())
    }

    func testHasNoDoubleQuotation() {
        let stringSurroundedNoDoubleQuotation = "jamie"
        XCTAssertFalse(stringSurroundedNoDoubleQuotation.hasDoubleQuotation())
    }

    func testHasOneDoubleQuotation() {
        let stringSurroundedOneDoubleQuotation = "\"jamie"
        XCTAssertFalse(stringSurroundedOneDoubleQuotation.hasDoubleQuotation())
    }

    func testHasTwoDoubleQuotation() {
        let stringSurroundedDoubleQuotation = "\"jamie\""
        XCTAssertTrue(stringSurroundedDoubleQuotation.hasDoubleQuotation())
    }

    func testHasNoCurlyBracket() {
        let stringSurroundedNoCurlyBracket = "\"name\" : \"jamie\""
        XCTAssertFalse(stringSurroundedNoCurlyBracket.hasSideCurlyBrackets())
    }

    func testHasOneCurlyBracket() {
        let stringSurroundedOneCurlyBracket = "{ \"name\" : \"jamie\""
        XCTAssertFalse(stringSurroundedOneCurlyBracket.hasSideCurlyBrackets())
    }

    func testHasTwoCurlyBrackets() {
        let stringSurroundedCurlyBrackets = "{ \"name\" : \"jamie\" }"
        XCTAssertTrue(stringSurroundedCurlyBrackets.hasSideCurlyBrackets())
    }

    func testTrimWhiteSpaces() {
        let trimmedWhiteSpaces = "\"name\" : \"jamie\""
        let stringSurroundedWhiteSpaces = " \"name\" : \"jamie\" "
        XCTAssertEqual(stringSurroundedWhiteSpaces.trimWhiteSpaces(), trimmedWhiteSpaces)
    }

    func testTrimSquareBrackets() {
        let trimmedSquareBrackets = " 10, \"jk\", 4, \"314\", 99, \"crong\", false "
        let jsonString = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        XCTAssertEqual(jsonString.trimSquareBrackets(), trimmedSquareBrackets)
    }

    func testTrimCurlyBrackets() {
        let trimmedCurlyBrackets = " \"name\" : \"jamie\" "
        let stringSurroundedCurlyBrackets = "{ \"name\" : \"jamie\" }"
        XCTAssertEqual(stringSurroundedCurlyBrackets.trimCurlyBrackets(), trimmedCurlyBrackets)
    }

    func testTrimDoubleQuotation() {
        let trimmedDoubleQuotation = "jamie"
        let stringSurroundedDoubleQuotation = "\"jamie\""
        XCTAssertEqual(stringSurroundedDoubleQuotation.trimDoubleQuotation(), trimmedDoubleQuotation)
    }

    func testSplitByComma() {
        let jsonString = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let splitArray = ["[ 10", " \"jk\"", " 4", " \"314\"", " 99", " \"crong\"", " false ]"]
        XCTAssertEqual(jsonString.splitByComma(), splitArray)
    }

    func testSplitByColon() {
        let jsonString = "\"name\" : \"jamie\""
        let splitArray = ["\"name\" ", " \"jamie\""]
        XCTAssertEqual(jsonString.splitByColon(), splitArray)
    }

}
