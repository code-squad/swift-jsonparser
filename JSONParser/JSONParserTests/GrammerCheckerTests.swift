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
    
    func testObject() {
        //given
        let object = "{ \"name\" : \"MINJI CHO\", \"alias\" : \"mindy\", \"level\" : 2, \"married\" : false }"
        
        //then
        XCTAssertTrue(GrammerChecker.isJSONFormat(of: object))
    }
    
    func testObject_whenKeyIsNotString() {
        // given
        let keyIsNotString = "{ name : \"Cho Minji\", \"alias\" : \"mindy\" }"
        
        // then
        XCTAssertFalse(GrammerChecker.isJSONFormat(of: keyIsNotString))
    }
    
    func testObject_whenObjectHasNotColon() {
        // given
        let hasNotColon = "{ \"name\" \"Lee Dong Young\", \"alias\" : \"Owl\" }"
        
        // then
        XCTAssertFalse(GrammerChecker.isJSONFormat(of: hasNotColon))
    }
    
    func testObject_whenHasArray() {
        // given
        let invalidInput = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        
        // then
        XCTAssertFalse(GrammerChecker.isJSONFormat(of: invalidInput))
    }
    
    func testObject_whenHasEmptyValue() {
        // given
        let emptyArray = "{ }"
        
        // then
        XCTAssertTrue(GrammerChecker.isJSONFormat(of: emptyArray))
    }
}
