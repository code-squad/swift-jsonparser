//
//  UnitTestJSONParser.swift
//  UnitTestJSONParser
//
//  Created by 김수현 on 2018. 4. 19..
//  Copyright © 2018년 JK. All rights reserved.
//

import XCTest

class UnitTestJSONParser: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testIsValiObjectFirstString() {
        let objectFrist = "{"
        let validobjectFrist = GrammarChecker().isValidFirstString(objectFrist)
        XCTAssertTrue(validobjectFrist)
    }
    
    func testIsValiObjectLastString() {
        let objectLast = "}"
        let validobjectLast = GrammarChecker().isValidLastString(objectLast)
        XCTAssertTrue(validobjectLast)
    }
    
    func testIsValidArrayFirstString() {
        let arrayFirst = "["
        let validarrayFirst = GrammarChecker().isValidFirstString(arrayFirst)
        XCTAssertTrue(validarrayFirst)
    }
    
    func testIsValidArrayLastString() {
        let arrayLast = "]"
        let validarrayLast = GrammarChecker().isValidLastString(arrayLast)
        XCTAssertTrue(validarrayLast)
    }
    
    func testIsValidOfIntValue() {
        let number = ["number":3]
        let validOfNumber = GrammarChecker().isValidOfDictionary(number)
        XCTAssertTrue(validOfNumber)
    }
    
    func testIsValidOfBoolValue() {
        let bool = ["bool":true]
        let validOfBool = GrammarChecker().isValidOfDictionary(bool)
        XCTAssertTrue(validOfBool)
    }
    
    func testIsValidOfStringValue() {
        let string = ["\"string\"":"\"abc\""]
        let validOfString = GrammarChecker().isValidOfDictionary(string)
        XCTAssertTrue(validOfString)
    }
    
    func testIsInvalidOfStringValue() {
        let string = ["string":"abc"]
        let validOfString = GrammarChecker().isValidOfDictionary(string)
        XCTAssertFalse(validOfString)
    }
    
    func testJSONDataNotNil() {
        let input = "{ \"name\" : \"KIM   JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        let jsonData = MyJsonParser().checkBrackets(input)
        XCTAssertNotNil(jsonData)
    }
    
}
