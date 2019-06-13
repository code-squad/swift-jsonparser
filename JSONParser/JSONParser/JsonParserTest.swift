//
//  JsonParser.swift
//  JsonParser
//
//  Created by 이희찬 on 03/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class FormatTest: XCTestCase {
    
    func testCorrectFormatOfJSON() {
        XCTAssertNoThrow(try Validator.JSONArrayformat(input: "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false]"))
    }

    func testInCorrectFormatOfJSON() {
        XCTAssertThrowsError(try Validator.JSONArrayformat(input: " 10, \"jk\", 4, \"314\", 99, \"crong\", false"))
    }
    
    func testCanConvertData() {
        var dataParser = DataParsingFactory()
        XCTAssertNoThrow(try dataParser.makeParsingData(data: "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false]"))
    }
    
    func testContainCanNotConvertData() {
        var dataParser = DataParsingFactory()
        XCTAssertThrowsError(try dataParser.makeParsingData(data: "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false, canNotConvertData]"))
    }

}
