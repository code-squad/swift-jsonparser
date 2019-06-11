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
        let datas = Converter.convertToArray(JSON: "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false]")
        var dataParser = DataParsingFactory()
        XCTAssertNoThrow(try dataParser.makeParsingData(data: datas))
    }
    
    func testContainCanNotConvertData() {
        let datas = Converter.convertToArray(JSON: "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false, canNotConvertData]")
        var dataParser = DataParsingFactory()
        XCTAssertThrowsError(try dataParser.makeParsingData(data: datas))
    }

}
