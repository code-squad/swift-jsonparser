//
//  JSONParserTests.swift
//  JSONParserTests
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest
@testable import JSONParser

class JSONParserTests: XCTestCase {
    
    func testValidationOfBasicArray() throws {
        let data: String = "[ \"sdf\" , 234 , true, false ]"
        XCTAssertTrue(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWholeDataCountOfBasicArray() throws {
        let data: String = "[ \"sdf\" , 234 , true, false ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.count, 4)
    }
    
    func testStringDataCountInBasicArray() throws {
        let data: String = "[ \"sdf\" , 234 , true, false ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.string, 1)
    }
    
    func testNumberDataCountInBasicArray() throws {
        let data: String = "[ \"sdf\" , 234 , true, false ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.number, 1)
    }
    
    func testBoolDataCountInBasicArray() throws {
        let data: String = "[ \"sdf\" , 234 , true, false ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.bool, 2)
    }
    
    func testValidationOfBasicObject() throws {
        let data: String = "{\"name\":\"KIM JUNG\",\"alias\":\"JK\",\"level\":5,\"married\":true}"
        XCTAssertTrue(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWholeDataCountOfBasicObject() throws {
        let data: String = "{\"name\":\"KIM JUNG\",\"alias\":\"JK\",\"level\":5,\"married\":true}"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.count, 4)
    }
    
    func testNumberDataCountInBasicObject() throws {
        let data: String = "{\"name\":\"KIM JUNG\",\"alias\":\"JK\",\"level\":5,\"married\":true}"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.objectCount.number, 1)
    }
    
    func testStringDataCountInBasicObject() throws {
        let data: String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\",\"level\":5,\"married\":true}"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.objectCount.string, 2)
    }
    
    func testBoolDataCountInBasicObject() throws {
        let data: String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\",\"level\":5,\"married\":true}"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.objectCount.bool, 1)
    }
    
    func testValidationOfArrayWithNestedObject() throws {
        let data: String = "[ \"kfdl\", \"jkldsf\", \"sdf\", false, \"ghf\", 890, { \"asdf\": \"asdf\", \"hrtdg\": 234}, { \"ertgf\": true } ]"
        XCTAssertTrue(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWholeDataCountOfArrayWithNestedObject() throws {
        let data: String = "[ \"kfdl\", \"jkldsf\", \"sdf\", false, \"ghf\", 890, { \"asdf\": \"asdf\", \"hrtdg\": 234}, { \"ertgf\": true } ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.count, 8)
    }
    
    func testNestedObjectDataCountInArray() throws {
        let data: String = "[ \"kfdl\", \"jkldsf\", \"sdf\", false, \"ghf\", 890, { \"asdf\": \"asdf\", \"hrtdg\": 234}, { \"ertgf\": true } ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.nestedObject, 2)
    }
    
    func testStringDataCountWithNestedObjectInArray() throws {
        let data: String = "[ \"kfdl\", \"jkldsf\", \"sdf\", false, \"ghf\", 890, { \"asdf\": \"asdf\", \"hrtdg\": 234}, { \"ertgf\": true } ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.string, 4)
    }
    
    func testNumberDataCountWithNestedObjectInArray() throws {
        let data: String = "[ \"kfdl\", \"jkldsf\", \"sdf\", false, \"ghf\", 890, { \"asdf\": \"asdf\", \"hrtdg\": 234}, { \"ertgf\": true } ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.number, 1)
    }
    
    func testBoolDataCountWithNestedObjectInArray() throws {
        let data: String = "[ \"kfdl\", \"jkldsf\", \"sdf\", false, \"ghf\", 890, { \"asdf\": \"asdf\", \"hrtdg\": 234}, { \"ertgf\": true } ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.bool, 1)
    }
    
    func testValidationOfArrayWithNestedArray() throws {
        let data: String = "[ \"sdf\" , 234 , true, [\"Sdf\", 789, true, false], 890]"
        XCTAssertTrue(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWholeDataCountOfArrayWithNestedArray() throws {
        let data: String = "[ \"sdf\" , 234 , true, [\"Sdf\", 789, true, false], 890]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.count, 5)
    }
    
    func testNestedArrayDataCountInArray() throws {
        let data: String = "[ \"sdf\" , 234 , true, [\"Sdf\", 789, true, false], 890]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.nestedArray, 1)
    }
    
    func testStringDataCountWithNestedArrayInArray() throws {
        let data: String = "[ \"sdf\" , 234 , true, [\"Sdf\", 789, true, false], 890]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.string, 1)
    }
    
    func testNumberDataCountWithNestedArrayInArray() throws {
        let data: String = "[ \"sdf\" , 234 , true, [\"Sdf\", 789, true, false], 890]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.number, 2)
    }
    
    func testBoolDataCountWithNestedArrayInArray() throws {
        let data: String = "[ \"sdf\" , 234 , true, [\"Sdf\", 789, true, false], 890]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.bool, 1)
    }
    
    func testValidationOfArrayWithMultiNestedBlobs() throws {
        let data: String = "[ \"gggd\", true, false, { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"asdf\":\"asdf\",\"hrtdg\":234}, {\"ertgf\":true}, [\"asdf\",234,\"ertgf\"], 3456 ]"
        XCTAssertTrue(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWholeDataCountWithMultiNestedBlobsInArray() throws {
        let data: String = "[ \"gggd\", true, false, { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"asdf\":\"asdf\",\"hrtdg\":234}, {\"ertgf\":true}, [\"asdf\",234,\"ertgf\"], 3456 ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.count, 9)
    }
    
    func testNestedArrayCountWithMultiNestedBlobsInArray() throws {
        let data: String = "[ \"gggd\", true, false, { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"asdf\":\"asdf\",\"hrtdg\":234}, {\"ertgf\":true}, [\"asdf\",234,\"ertgf\"], 3456 ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.nestedArray, 2)
    }
    
    func testNestedObjectCountWithMultiNestedBlobsInArray() throws {
        let data: String = "[ \"gggd\", true, false, { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"asdf\":\"asdf\",\"hrtdg\":234}, {\"ertgf\":true}, [\"asdf\",234,\"ertgf\"], 3456 ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.nestedObject, 3)
    }
    
    func testStringDataCountWithMultiNestedBlobsInArray() throws {
        let data: String = "[ \"gggd\", true, false, { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"asdf\":\"asdf\",\"hrtdg\":234}, {\"ertgf\":true}, [\"asdf\",234,\"ertgf\"], 3456 ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.string, 1)
    }
    
    func testNumberDataCountWithMultiNestedBlobsInArray() throws {
        let data: String = "[ \"gggd\", true, false, { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"asdf\":\"asdf\",\"hrtdg\":234}, {\"ertgf\":true}, [\"asdf\",234,\"ertgf\"], 3456 ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.number, 1)
    }
    
    func testBoolDataCountWithMultiNestedBlobsInArray() throws {
        let data: String = "[ \"gggd\", true, false, { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"asdf\":\"asdf\",\"hrtdg\":234}, {\"ertgf\":true}, [\"asdf\",234,\"ertgf\"], 3456 ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.bool, 2)
    }
    
    func testValidationOfObjectWithMultiNestedBlobs() throws {
        let data: String = "{ \"sadf\":true, \"ghdf\": 234, \"gdsfg\":234, \"sdf\": {\"asdf\": \"Asdf\", \"asdf\": 324 }, \"sdf\":[true, false, 234 ] }"
        XCTAssertTrue(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWholeDataCountWithMultiNestedBlobsInObject() throws {
        let data: String = "{ \"JK\":true, \"Alley\": 234, \"Lemon\":234, \"Aming\": {\"Alien\": \"Asdf\", \"Napster\": 324, \"Jake\":true }, \"Hoon\":[true, false, 234, \"Jack\"], \"Min\": false }"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.count, 6)
    }
    
    func testNestedArrayCountWithMultiNestedBlobsInObject() throws {
        let data: String = "{ \"JK\":true, \"Alley\": 234, \"Lemon\":234, \"Aming\": {\"Alien\": \"Asdf\", \"Napster\": 324, \"Jake\":true }, \"Hoon\":[true, false, 234, \"Jack\"], \"Min\": false }"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.objectCount.nestedArray, 1)
    }
    
    func testNestedObjectCountWithMultiNestedBlobsInObject() throws {
        let data: String = "{ \"JK\":true, \"Alley\": 234, \"Lemon\":234, \"Aming\": {\"Alien\": \"Asdf\", \"Napster\": 324, \"Jake\":true }, \"Hoon\":[true, false, 234, \"Jack\"], \"Min\": false }"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.objectCount.nestedObject, 1)
    }
    
    func testStringCountWithMultiNestedBlobsInObject() throws {
        let data: String = "{ \"JK\":true, \"Alley\": 234, \"Lemon\":234, \"Aming\": {\"Alien\": \"Asdf\", \"Napster\": 324, \"Jake\":true }, \"Hoon\":[true, false, 234, \"Jack\"], \"Min\": false }"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.objectCount.string, 0)
    }
    
    func testNumberCountWithMultiNestedBlobsInObject() throws {
        let data: String = "{ \"JK\":true, \"Alley\": 234, \"Lemon\":234, \"Aming\": {\"Alien\": \"Asdf\", \"Napster\": 324, \"Jake\":true }, \"Hoon\":[true, false, 234, \"Jack\"], \"Min\": false }"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.objectCount.number, 2)
    }
    
    func testBoolCountWithMultiNestedBlobsInObject() throws {
        let data: String = "{ \"JK\":true, \"Alley\": 234, \"Lemon\":234, \"Aming\": {\"Alien\": \"Asdf\", \"Napster\": 324, \"Jake\":true }, \"Hoon\":[true, false, 234, \"Jack\"], \"Min\": false }"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.objectCount.bool, 2)
    }
    
    func testInvalidArrayPattern() throws {
        let data: String = "[ \"name\" : \"KIM JUNG\" ]"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testInvalidArrayPatternNestedOverTwoDepth() throws {
        let data: String = "[[\"sdf\",\"sadf\", {\"Asdf\":234} ],true,\"sdf\",false,324]"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testObjectKeyContainsWhitespace() throws {
        let data: String = "{\" dsf\":234}"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWithoutCommaInObject() throws {
        let data: String = "{ \"asdf\" : 234\"asdf\":true}"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWithoutCommaInArray() throws {
        let data: String = "[ \"asdf\"234, true]"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWithNoOutermostBrackets() throws {
        let data: String = "\"sdf\":234,\"324\":true"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testInvalidArrayDataInObject() throws {
        let data: String = "{ \"asdf\" : 324, [\"asdf\",234]}"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
}
