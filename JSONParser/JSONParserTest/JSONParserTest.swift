//
//  JSONParserTest.swift
//  JSONParserTest
//
//  Created by 이동건 on 09/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest

class JSONParserFormatTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSingleObject(){
        let object = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertTrue(object.isValid, "This is not a valid form")
    }
    
    func testObjectsInArray(){
        let objectsInArray = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
        XCTAssertTrue(objectsInArray.isValid, "This is not a valid form")
    }
    
    func testNestedFormWithSpace() {
        let nested = "{ [ ] }"
        XCTAssertFalse(nested.isValid, "This is not a nested form")
    }
    
    func testCurlyBracketsNestedFormWithSpace(){
        let nested = "{ { } }"
        XCTAssertFalse(nested.isValid, "This is not a nested form")
    }
    
    func testNestedFormWithoutSpace() {
        let nested = "{[]}"
        XCTAssertFalse(nested.isValid, "This is not a nested form")
    }
    
    func testCurlyBracketsNestedFormWithoutSpace() {
        let nested = "{{}}"
        XCTAssertFalse(nested.isValid, "This is not a nested form")
    }
    
    func testNestedFormat(){
        let nested = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        XCTAssertFalse(nested.isValid, "This is not a nested form")
    }
    
    func testPairsInArrayWithSpace(){
        let pairsInArray = "[ don : 1\"23 ]"
        XCTAssertFalse(pairsInArray.isValid, "This is not a pairInArray form")
    }
    
    func testPairsInArrayWithoutSpace(){
        let pairsInArray = "[don:1\"23]"
        XCTAssertFalse(pairsInArray.isValid, "This is not a pairInArray form")
    }
    
    func testPairsInArrayFormat(){
        let pairsInArray = "[ \"name\" : \"KIM JUNG\" ]"
        XCTAssertFalse(pairsInArray.isValid, "This is not a pairInArray form")
    }
}
