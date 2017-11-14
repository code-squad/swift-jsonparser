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
        
        let checker = GrammarChecker()
        var elementsFromArray : Array<String> = []
        var elements : String = arrayTester.trimmingCharacters(in: ["[","]"])
        XCTAssertEqual(elements, " 10, \"jk\", 4, \"314\", 99, \"crong\", false ")
        elementsFromArray.append(contentsOf: checker.getArrayMatches(from: elements))
        XCTAssertEqual(elements, " 10, \"jk\", 4, \"314\", 99, \"crong\", false ")
        elements = checker.removeMatchedArray(target: elements)
        XCTAssertEqual(elements, " 10, \"jk\", 4, \"314\", 99, \"crong\", false ")
        elementsFromArray.append(contentsOf: checker.getObjectMatches(from: elements))
        elements = checker.removeMatchedObject(target: elements)
        XCTAssertEqual(elements, " 10, \"jk\", 4, \"314\", 99, \"crong\", false ")
        elementsFromArray.append(contentsOf: elements.getElements())
        XCTAssertEqual(elementsFromArray, [ "10", "\"jk\"", "4", "\"314\"", "99", "\"crong\"", "false" ])
    }
    
    func testGetElements() {
        XCTAssertEqual(arrayTester.trimmingCharacters(in: ["[","]"]).getElements(), ["10", "\"jk\"", "4", "\"314\"", "99", "\"crong\"", "false"])
    }
    
    func testGetElementsForObject() {
        XCTAssertEqual(objectTester.getElementsForObject(), ["\"name\" : \"KIM JUNG\"", "\"alias\" : \"JK\"", "\"level\" : 5", "\"married\" : true"])
    }
    
}
