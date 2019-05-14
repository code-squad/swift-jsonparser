//
//  JSONParserTest.swift
//  JSONParserTest
//
//  Created by joon-ho kil on 5/14/19.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class JSONParserTest: XCTestCase {
    func testInputError() {
        XCTAssertNoThrow(try checkInputError("[ 10, 21, 4, 314, 99, 0, 72 ]"))
        XCTAssertNoThrow(try checkInputError("[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"))
        XCTAssertNoThrow(try checkInputError("{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"))
        XCTAssertNoThrow(try checkInputError("[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"))
        XCTAssertThrowsError(try checkInputError("[ \"name\" : \"KIM JUNG\" ]"))
        XCTAssertThrowsError(try checkInputError("{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"))
        XCTAssertNoThrow(try checkInputError("[ 72 ]"))
        XCTAssertNoThrow(try checkInputError("[ { \"name\" : \"dominic\" } ]"))
        XCTAssertThrowsError(try checkInputError("[ \"name\" : \"KIM JUNG\" }"))
        XCTAssertThrowsError(try checkInputError("[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5 }, { \"name\" : \"YAGOM\" } "))
    }
    
    func checkInputError (_ input: String) throws {
        try GrammarChecker.checkJsonGrammar(input)
        try Converter.stringToJson(input)
    }
}
