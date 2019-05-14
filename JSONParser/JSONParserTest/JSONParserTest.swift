//
//  JSONParserTest.swift
//  JSONParserTest
//
//  Created by joon-ho kil on 5/14/19.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class JSONParserTest: XCTestCase {
    func testStringToJson() {
        XCTAssertNoThrow(try GrammarChecker.checkJsonGrammar("[ 10, 21, 4, 314, 99, 0, 72 ]"))
        XCTAssertNoThrow(try GrammarChecker.checkJsonGrammar("[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"))
        XCTAssertNoThrow(try GrammarChecker.checkJsonGrammar("{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"))
        XCTAssertNoThrow(try GrammarChecker.checkJsonGrammar("[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"))
        XCTAssertThrowsError(try GrammarChecker.checkJsonGrammar("[ \"name\" : \"KIM JUNG\" ]"))
    }
}
