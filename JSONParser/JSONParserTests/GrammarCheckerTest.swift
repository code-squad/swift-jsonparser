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
    var objectTester : String = "{ \"name\": \"KIM JUNG\", \"alias\" :\"JK\", \"level\" : 5, \"married\" : true }"
    var errorTesterForObject : String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
    var arrayTester : String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
    var errorTesterForArray : String = "[ \"name\" : \"KIM JUNG\" ]"
    
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
    
    func testIsJSONPatternForObject() {
        XCTAssertNoThrow(try grammarChecker.isJSONPattern(target: objectTester))
        XCTAssertThrowsError(try grammarChecker.isJSONPattern(target: errorTesterForObject))
    }

}
