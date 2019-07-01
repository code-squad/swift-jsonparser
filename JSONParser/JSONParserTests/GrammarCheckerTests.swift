//
//  GrammarCheckerTests.swift
//  JSONParserTests
//
//  Created by JieunKim on 01/07/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class GrammarCheckerTests: XCTestCase {

    func testWrongFormat() {
        //Given
        let array = "[ Ogi is pretty¸ ]"
        
        //Then
        XCTAssertFalse(GrammarChecker.isValid(array))
    }
    
    func testIsVaildArray() {
        //Given
        let array = "[ 1, 23, 4, true, \"Hello\" ]"
        
       //Then
        XCTAssertTrue(GrammarChecker.isValid(array))
    }
    
    func testIsVaildObject() {
        //Given
        let object = "{ \"name\" : \"zieunv\" }"
        
       //Then
        XCTAssertTrue(GrammarChecker.isValid(object))
        
    }
    
    func testIsVaildNestedArray() {
        //Given
        let nestedArray = "[ 1, 23, 4, true, \"Hello\",[ 1, 23, 4, true, \"Hello\"] ]"
        
        //Then
        XCTAssertTrue(GrammarChecker.isValid(nestedArray))
    }
    
    func testIsVaildNestedObject() {
        //Given
        let nestedObject = "{ \"name\" : \"zieunv\", \"object\" : { \"name\" : \"OWL\" } }"
        
        //Then
        XCTAssertTrue(GrammarChecker.isValid(nestedObject))
        
    }
}
