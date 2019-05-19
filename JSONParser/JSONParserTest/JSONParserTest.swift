//
//  JSONParserTest.swift
//  JSONParserTest
//
//  Created by joon-ho kil on 5/14/19.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class JSONParserTest: XCTestCase {
    func testArraySuccess() {
        XCTAssertNoThrow(try GrammarChecker.checkJsonGrammar("[ 10, 21, 4, 314, 99, 0, 72 ]"))
        XCTAssertNoThrow(try GrammarChecker.checkJsonGrammar("[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"))
        XCTAssertNoThrow(try GrammarChecker.checkJsonGrammar("[ 72 ]"))
        XCTAssertNoThrow(try GrammarChecker.checkJsonGrammar("[ { \"name\" : \"dominic\" } ]"))
        XCTAssertNoThrow(try GrammarChecker.checkJsonGrammar("[ { \"name\" : \"master's course\", \"opened\" : true }, [ \"java\", \"javascript\", \"swift\" ] ]"))
    }
    func testArrayFail() {
        XCTAssertThrowsError(try GrammarChecker.checkJsonGrammar("[ \"name\" : \"KIM JUNG\" ]"))
        XCTAssertThrowsError(try GrammarChecker.checkJsonGrammar("[ \"name\" : \"KIM JUNG\" }"))
        XCTAssertThrowsError(try GrammarChecker.checkJsonGrammar("[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5 }, { \"name\" : \"YAGOM\" } "))
    }
    func testObjectSuccess() {
        XCTAssertNoThrow(try GrammarChecker.checkJsonGrammar("{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"))
        XCTAssertNoThrow(try GrammarChecker.checkJsonGrammar("{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"))
    }
    func testObjectFail() {
        XCTAssertThrowsError(try GrammarChecker.checkJsonGrammar("{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5 }, { \"name\" : \"YAGOM\" } "))
        XCTAssertThrowsError(try GrammarChecker.checkJsonGrammar("{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : fale }"))
    }
}
