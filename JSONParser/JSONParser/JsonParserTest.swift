//
//  JsonParser.swift
//  JsonParser
//
//  Created by 이희찬 on 03/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class JsonParser: XCTestCase {
    
    func testCorrectFormatOfJSON() {
        XCTAssertNoThrow(try Validator.JSONArrayformatValidator(input: "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false]"))
    }

    func testInCorrectFormatOfJSON() {
        XCTAssertThrowsError(try Validator.JSONArrayformatValidator(input: " 10, \"jk\", 4, \"314\", 99, \"crong\", false"))
    }
    
    func testCanConvertData() {
        let json = Converter.convertToArray(JSON: "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false]")
        var counter = Counter()
        XCTAssertNoThrow(try counter.dataTypeCounter(convertedJSONToArray: json))
    }
    
    func testContainCanNotConvertData() {
        let json = Converter.convertToArray(JSON: "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false, canNotConvertData]")
        var counter = Counter()
        XCTAssertThrowsError(try counter.dataTypeCounter(convertedJSONToArray: json))
    }

}
