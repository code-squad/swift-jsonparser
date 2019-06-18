//
//  GrammerCheckerTests.swift
//  JSONParserTests
//
//  Created by CHOMINJI on 18/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class GrammerCheckerTests: XCTestCase {
    
    func testArray() {
        // given
        let multiObject = "[ { \"name\" : \"MINJI CHO\", \"alias\" : \"mindy\", \"level\" : 2, \"married\" : false }, { \"name\" : \"HELLO HI\", \"alias\" : \"hi\", \"level\" : 4, \"married\" : true } ]"
        let multiValuesIncludeObject = "[ 15, false, { \"name\" : \"MINJI CHO\", \"alias\" : \"mindy\", \"level\" : 2, \"married\" : false },true, \"hihi\", false, { \"name\" : \"HELLO HI\", \"alias\" : \"hi\", \"level\" : 4, \"married\" : true } ]"
        
        // then
        XCTAssertTrue(GrammerChecker.isJSONFormat(of: multiObject))
        XCTAssertTrue(GrammerChecker.isJSONFormat(of: multiValuesIncludeObject))
    }
    
    func testArray_whenHasKeyValue() {
        // given
        let invalidInput = "[ \"name\" : \"mindy\" ]"
        
        // then
        XCTAssertFalse(GrammerChecker.isJSONFormat(of: invalidInput))
    }
    
    func testArray_whenHasEmptyValue() {
        // given
        let emptyArray = "[ ]"
        
        // then
        XCTAssertTrue(GrammerChecker.isJSONFormat(of: emptyArray))
    }
}
