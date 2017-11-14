//
//  GrammarCheckerTest.swift
//  JSONParserTests
//
//  Created by TaeHyeonLee on 2017. 11. 10..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest

@testable import JSONParser

class GrammarCheckerTest: XCTestCase {
    var grammarChecker : GrammarChecker!
    // object
    var objectTester : String = "{ \"name\": \"KIM JUNG\", \"alias\" :\"JK\", \"level\" : 5, \"married\" : true }"
    var errorTesterForObject : String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
    let nestedObjectTester : String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"], \"test\" : { \"test\" : \"tester\" } }"
    // array
    var arrayTester : String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
    var errorTesterForArray : String = "[ \"name\" : \"KIM JUNG\" ]"
    let nestedArrayTester : String = "[ { \"test\" : \"tester\" }, [1,2,3] ]"
    
    override func setUp() {
        super.setUp()
        grammarChecker = GrammarChecker()
    }
    
    override func tearDown() {
        super.tearDown()
        grammarChecker = nil
    }
    
    func testIsJSONPatternForArray() {
        XCTAssertNoThrow(try grammarChecker.isJSONPattern(target: arrayTester))
        XCTAssertThrowsError(try grammarChecker.isJSONPattern(target: errorTesterForArray))
    }
    
    func testIsJSONPatternForNestedArray() {
        XCTAssertNoThrow(try grammarChecker.isJSONPattern(target: nestedArrayTester))
        XCTAssertThrowsError(try grammarChecker.isJSONPattern(target: errorTesterForArray))
    }
    
    func testIsJSONPatternForObject() {
        XCTAssertNoThrow(try grammarChecker.isJSONPattern(target: objectTester))
    }
    
    func testIsJSONPatternForNestedObject() {
        XCTAssertNoThrow(try grammarChecker.isJSONPattern(target: nestedObjectTester))
    }
    
    func testGetArrayMatches() {
        XCTAssertEqual(grammarChecker.getArrayMatches(from: nestedArrayTester), ["[1,2,3]"])
    }
    
    func testGetObjectMatches() {
        XCTAssertEqual(grammarChecker.getObjectMatches(from: nestedArrayTester), ["{ \"test\" : \"tester\" }"])
    }
    
    func testRemoveMatchedArray() {
        XCTAssertEqual(grammarChecker.removeMatchedArray(target: nestedArrayTester), "[ { \"test\" : \"tester\" }, ]")
    }
    
    func testRemoveMatchedObject() {
        XCTAssertEqual(grammarChecker.removeMatchedObject(target: nestedArrayTester), "[ , [1,2,3] ]")
    }
    
    func testRemoveMatchedAll() {
        var tester = grammarChecker.removeMatchedArray(target: nestedArrayTester)
        tester = grammarChecker.removeMatchedObject(target: tester)
        XCTAssertEqual(tester, "[ , ]")
    }
    
}
