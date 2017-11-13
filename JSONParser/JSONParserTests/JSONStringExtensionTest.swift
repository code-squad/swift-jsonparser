//
//  JSONStringExtensionTest.swift
//  JSONParserTests
//
//  Created by TaeHyeonLee on 2017. 11. 8..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest

@testable import JSONParser

class JSONStringExtensionTest: XCTestCase {
    let arrayTester : String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
    let objectTester : String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
    let errorTesterForArray : String = "[ \"name\" : \"KIM JUNG\" ]"
    let errorTesterForObject : String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testGetElementsAll() {
        XCTAssertEqual(arrayTester.getElementsAll(), ["10", "\"jk\"", "4", "\"314\"", "99", "\"crong\"", "false"])
    }
    
    func testGetElements() {
        XCTAssertEqual(arrayTester.trimmingCharacters(in: ["[","]"]).getElements(), ["10", "\"jk\"", "4", "\"314\"", "99", "\"crong\"", "false"])
    }
    
    func testGetElementsForObject() {
        XCTAssertEqual(objectTester.getElementsForObject(), ["\"name\" : \"KIM JUNG\"", "\"alias\" : \"JK\"", "\"level\" : 5", "\"married\" : true"])
    }
    
    func testIsJSONPatternForArray() {
        XCTAssertNoThrow(try arrayTester.isJSONPattern())
        XCTAssertThrowsError(try errorTesterForArray.isJSONPattern())
    }
    
    func testIsJSONPatternForObject() {
        XCTAssertNoThrow(try objectTester.isJSONPattern())
        XCTAssertThrowsError(try errorTesterForObject.isJSONPattern())
    }
    
}
