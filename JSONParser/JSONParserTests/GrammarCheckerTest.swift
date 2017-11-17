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
    var objectTester : String = "{ \"name\": \"KIM JUNG\", \"alias\" :\"J_K\", \"level\" : 5, \"married\" : true }"
    var errorTesterForObject : String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : errortest }"
    let nestedObjectTester : String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"], \"test\" : { \"test\" : \"tester\" } }"
    // array
    var arrayTester : String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
    var errorTesterForArray : String = "[ \"name\" :  \"KIM JUNG\" ]"
    let nestedArrayTester : String = "[ { \"name\" : \"master's course\", \"opened\" : true }, [ \"java\", \"javascript\", \"swift\" ] ]"
    
    override func setUp() {
        super.setUp()
        grammarChecker = GrammarChecker()
    }
    
    override func tearDown() {
        super.tearDown()
        grammarChecker = nil
    }
    
    func testIsJSONPatternForArray() {
        XCTAssertTrue(grammarChecker.isJSONPattern(target: arrayTester))
    }

    func testIsJSONPatternForNotArray() {
        XCTAssertFalse(grammarChecker.isJSONPattern(target: errorTesterForArray))
    }
    
    func testIsJSONPatternForNestedArray() {
        XCTAssertTrue(grammarChecker.isJSONPattern(target: nestedArrayTester))
    }
    
    func testIsJSONPatternForObject() {
        XCTAssertTrue(grammarChecker.isJSONPattern(target: objectTester))
    }

    func testIsJSONPatternForNotObject() {
        XCTAssertFalse(grammarChecker.isJSONPattern(target: errorTesterForObject))
    }
    
    func testIsJSONPatternForNestedObject() {
        XCTAssertTrue(grammarChecker.isJSONPattern(target: nestedObjectTester))
    }

}
