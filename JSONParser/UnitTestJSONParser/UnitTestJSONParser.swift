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
    private let objectSeparatePattern = "([^\\,\\{\\}]+)"
    private let arrayCheckAndSeparatePattern = "(\\{[^\\{\\}]*\\})|(true|false)|(\\d+)|(\".+?\")|(:)"
    
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
        XCTAssertThrowsError(try parserTest.makeJSONData(testRawJSONData1))
    }
    
    func testJSONParserObjectInArrayCASE1() {
        let parserTest = JSONParser()
        let testRawJSONData1 = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
        XCTAssertEqual(try! parserTest.makeJSONData(testRawJSONData1).objectTypeCount, 2)
    }
    
    func testJSONParserObjectInArrayFirstAndEndObjects() {
        let parser = JSONParser()
        let testRawJSONData1 = "[ { \"name\" : \"Lee\" }, 123, \"Lee\", true, { \"name\" : \"JIN\" } ]"
        let parserTypeCount = try! parser.makeJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.objectTypeCount, 2)
    }
    
    func testJSONParserObjectInArrayObjectOfEnd() {
        let parser = JSONParser()
        let testRawJSONData1 = "[ 123, \"Lee\", true, { \"name\" : \"Lee\" } ]"
        let parserTypeCount = try! parser.makeJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.objectTypeCount, 1)
    }
    
    func testJSONParserObjectInArrayObjectOfCenter() {
        let parser = JSONParser()
        let testRawJSONData1 = "[ 123, \"Lee\", true, { \"name\" : \"JIN\" }, 123, \"Lee\", true ]"
        let parserTypeCount = try! parser.makeJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.objectTypeCount, 1)
    }
    
    func testMakeJSONDataMethod() {
        let parser = JSONParser()
        let testRawJSONData1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        XCTAssertThrowsError(try parser.makeJSONData(testRawJSONData1))
    }
    
    func testJSONParserObjectBoolCASE() {
        let parser = JSONParser()
        let testRawJSONData1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let separateValue = try! parser.makeJSONData(testRawJSONData1)
        XCTAssertEqual(separateValue.boolTypeCount, 1)
    }
    
    func testJSONParserObjectStringCASE() {
        let parser = JSONParser()
        let testRawJSONData1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let parserTypeCount = try! parser.makeJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.stringTypeCount, 2)
    }
    
    func testJSONParserObjectIntCASE() {
        let parser = JSONParser()
        let testRawJSONData1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let parserTypeCount = try! parser.makeJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.intTypeCount, 1)
    }
    
    func testJSONParserObjectSumOfDataCASE() {
        let parser = JSONParser()
        let testRawJSONData1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let parserTypeCount = try! parser.makeJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.sumOfData, 4)
    }
    
    func testJSONParserArrayMethodStringCASE() {
        let parser = JSONParser()
        let testRawJSONData1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let parserTypeCount = try! parser.makeJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.stringTypeCount, 2)
    }
    
    func testJSONParserArrayMethodIntCASE() {
        let parser = JSONParser()
        let testRawJSONData1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let parserTypeCount = try! parser.makeJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.intTypeCount, 1)
    }
    
    func testJSONParserArrayMethodBoolCASE() {
        let parser = JSONParser()
        let testRawJSONData1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let parserTypeCount = try! parser.makeJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.boolTypeCount, 1)
    }
    
    func testJSONParserArrayMethodSumOfDataCASE() {
        let parser = JSONParser()
        let testRawJSONData1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let parserTypeCount = try! parser.makeJSONData(testRawJSONData1)
        XCTAssertEqual(parserTypeCount.sumOfData, 4)
    }
    
    func testGrammarCheckerInvalidJSONAtArray() {
        let grammarCheckerTest = GrammarChecker()
        let testRawJSONData1 = "[ \"name\" : \"KIM JUNG\" ]"
        XCTAssertThrowsError(try grammarCheckerTest.checkAndSeparateArray(inString: testRawJSONData1))
    }
    
    func testGrammarCheckerAtObject() {
        let grammarCheckerTest = GrammarChecker()
        let testRawJSONData1 = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        XCTAssertThrowsError(try grammarCheckerTest.checkAndSeparateObject(inString: testRawJSONData1))
    }
}
