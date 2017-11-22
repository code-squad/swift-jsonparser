//
//  UnitTestJSONParser.swift
//  UnitTestJSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest
@testable import JSONParser

class UnitTestJSONParser: XCTestCase {
    override func setUp() { super.setUp() }
    override func tearDown() { super.tearDown() }
    
    func testJSONParserArrayWithIntsCASE() {
        let parserTest = JSONParser()
        let testRawJSONData = "[ 10, 21, 4, 314, 99, 0, 72 ]"
        XCTAssertEqual(try! parserTest.makeJSONData(testRawJSONData).intTypeCount, 7)
    }
    
    func testJSONParserArrayStringCASE() {
        let parserTest = JSONParser()
        let testRawJSONData = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        XCTAssertEqual(try! parserTest.makeJSONData(testRawJSONData).stringTypeCount, 3)
    }
    
    func testJSONParserArrayBoolCASE() {
        let parserTest = JSONParser()
        let testRawJSONData = "[ 10, \"jk\", 4, \"314\", true, \"crong\", false ]"
        XCTAssertEqual(try! parserTest.makeJSONData(testRawJSONData).boolTypeCount, 2)
    }
    
    func testJSONParserArraySumOfDataCASE() {
        let parserTest = JSONParser()
        let testRawJSONData = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        XCTAssertEqual(try! parserTest.makeJSONData(testRawJSONData).sumOfData, 7)
    }
    
    func testJSONParserArrayInvaildStandardCASE() {
        let parserTest = JSONParser()
        let testRawJSONData1 = " 10, 21, 4, 314, 99, 0, 72 ]"
        XCTAssertThrowsError(try parserTest.check(testRawJSONData1))
    }
    
    func testJSONParserObjectInArrayCASE1() {
        let parserTest = JSONParser()
        let testRawJSONData1 = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
        XCTAssertEqual(try! parserTest.makeJSONData(testRawJSONData1).objectTypeCount, 2)
    }
    
    func testJSONParserObjectInArrayFirstAndEndObjects() {
        let parserTest = JSONParser()
        let testRawJSONData1 = "[ { \"name\" : \"Lee\" }, 123, \"Lee\", true, { \"name\" : \"JIN\" } ]"
        let parserTypeCount = try! parserTest.makeJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.objectTypeCount, 2)
    }
    
    func testJSONParserObjectInArrayObjectOfEnd() {
        let parserTest = JSONParser()
        let testRawJSONData1 = "[ 123, \"Lee\", true, { \"name\" : \"Lee\" } ]"
        let parserTypeCount = try! parserTest.makeJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.objectTypeCount, 1)
    }
    
    func testJSONParserObjectInArrayObjectOfCenter() {
        let parserTest = JSONParser()
        let testRawJSONData1 = "[ 123, \"Lee\", true, { \"name\" : \"JIN\" }, 123, \"Lee\", true ]"
        let parserTypeCount = try! parserTest.makeJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.objectTypeCount, 1)
    }
    
    func testJSONParserObjectBoolCASE() {
        let parserTest = JSONParser()
        let testRawJSONData1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let parserTypeCount = parserTest.makeObjectJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.boolTypeCount, 1)
    }
    
    func testJSONParserObjectStringCASE() {
        let parserTest = JSONParser()
        let testRawJSONData1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let parserTypeCount = parserTest.makeObjectJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.stringTypeCount, 2)
    }
    
    func testJSONParserObjectIntCASE() {
        let parserTest = JSONParser()
        let testRawJSONData1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let parserTypeCount = parserTest.makeObjectJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.intTypeCount, 1)
    }
    
    func testJSONParserObjectSumOfDataCASE() {
        let parserTest = JSONParser()
        let testRawJSONData1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let parserTypeCount = parserTest.makeObjectJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.sumOfData, 4)
    }
    
    func testJSONParserArrayMethodStringCASE() {
        let parserTest = JSONParser()
        let testRawJSONData1 = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let arrayParserCount = try! parserTest.makeArrayJSONData(testRawJSONData1)
        XCTAssertEqual(arrayParserCount.stringTypeCount, 3)
    }
    
    func testJSONParserArrayMethodIntCASE() {
        let parserTest = JSONParser()
        let testRawJSONData1 = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let arrayParserCount = try! parserTest.makeArrayJSONData(testRawJSONData1)
        XCTAssertEqual(arrayParserCount.intTypeCount, 3)
    }
    
    func testJSONParserArrayMethodBoolCASE() {
        let parserTest = JSONParser()
        let testRawJSONData1 = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let arrayParserCount = try! parserTest.makeArrayJSONData(testRawJSONData1)
        XCTAssertEqual(arrayParserCount.boolTypeCount, 1)
    }
    
    func testJSONParserArrayMethodSumOfDataCASE() {
        let parserTest = JSONParser()
        let testRawJSONData1 = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let arrayParserCount = try! parserTest.makeArrayJSONData(testRawJSONData1)
        XCTAssertEqual(arrayParserCount.sumOfData, 7)
    }
    
    func testGrammarCheckerInvalidJSONAtArray() {
        let grammarCheckerTest = GrammarChecker()
        let testRawJSONData1 = "[ \"name\" : \"KIM JUNG\" ]"
        XCTAssertThrowsError(try grammarCheckerTest.checkArray(inString: testRawJSONData1))
    }
    
    func testGrammarCheckerAtObject() {
        let grammarCheckerTest = GrammarChecker()
        let testRawJSONData1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        XCTAssertThrowsError(try grammarCheckerTest.checkObject(inString: testRawJSONData1))
    }
}
