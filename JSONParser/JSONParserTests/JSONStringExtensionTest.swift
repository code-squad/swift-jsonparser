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
    let nestedObjectTester : String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
    let nestedArrayTester = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetElementsAll() {
        XCTAssertEqual(arrayTester.getElementsAll(), ["10", "\"jk\"", "4", "\"314\"", "99", "\"crong\"", "false"])
        XCTAssertEqual(nestedArrayTester.getElementsAll(), ["{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }","{ \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true }"])
    }
    
    func testGetElements() {
        XCTAssertEqual(arrayTester.trimmingCharacters(in: ["[","]"]).getElements(), ["10", "\"jk\"", "4", "\"314\"", "99", "\"crong\"", "false"])
    }
    
    func testGetObjectElements() {
        XCTAssertEqual(objectTester.getObjectElements(), ["\"name\" : \"KIM JUNG\"", "\"alias\" : \"JK\"", "\"level\" : 5", "\"married\" : true"])
    }
    
    func testGetObjectElementsForNestedObject() {
        XCTAssertEqual(nestedObjectTester.getObjectElements(), ["\"name\" : \"KIM JUNG\"","\"alias\" : \"JK\"","\"level\" : 5","\"children\" : [\"hana\", \"hayul\", \"haun\"]"])
    }
    
}
