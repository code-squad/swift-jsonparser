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
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testJSONStringExtension() {
        var tester : String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        XCTAssertEqual(tester.getElementsAll(), ["10", "\"jk\"", "4", "\"314\"", "99", "\"crong\"", "false"])
        tester = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]".trimmingCharacters(in: ["[","]"])
        XCTAssertEqual(tester.getElements(), ["10", "\"jk\"", "4", "\"314\"", "99", "\"crong\"", "false"])
        tester = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertEqual(tester.getElementsForObject(), ["\"name\" : \"KIM JUNG\"", "\"alias\" : \"JK\"", "\"level\" : 5", "\"married\" : true"])
    }
    
}
