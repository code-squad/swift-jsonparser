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
        let data: String = "[ \"JK\" , 234 , true, false ]"
        XCTAssertTrue(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWholeDataCountOfBasicArray() throws {
        let data: String = "[ \"JK\" , 234 , true, false ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.count, 4)
    }
    
    func testStringDataCountInBasicArray() throws {
        let data: String = "[ \"JK\" , 234 , true, false ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.string, 1)
    }
    
    func testNumberDataCountInBasicArray() throws {
        let data: String = "[ \"JK\" , 234 , true, false ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.number, 1)
    }
    
    func testBoolDataCountInBasicArray() throws {
        let data: String = "[ \"JK\" , 234 , true, false ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.bool, 2)
    }
    
    func testValidationOfBasicObject() throws {
        let data: String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\": true }"
        XCTAssertTrue(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWholeDataCountOfBasicObject() throws {
        let data: String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\": true }"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.count, 4)
    }
    
    func testNumberDataCountInBasicObject() throws {
        let data: String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\": true }"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.number, 1)
    }
    
    func testStringDataCountInBasicObject() throws {
        let data: String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\": true }"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.string, 2)
    }
    
    func testBoolDataCountInBasicObject() throws {
        let data: String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\": true }"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.bool, 1)
    }
    
    func testValidationOfArrayWithNestedObject() throws {
        let data: String = "[ \"Napster\", \"Lemon\", \"Alley\", false, \"Alien\", 890, { \"Aming\": \"Jake\", \"Hoon\": 234}, { \"Jack\": true } ]"
        XCTAssertTrue(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWholeDataCountOfArrayWithNestedObject() throws {
        let data: String = "[ \"Napster\", \"Lemon\", \"Alley\", false, \"Alien\", 890, { \"Aming\": \"Jake\", \"Hoon\": 234}, { \"Jack\": true } ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.count, 8)
    }
    
    func testNestedObjectDataCountInArray() throws {
        let data: String = "[ \"Napster\", \"Lemon\", \"Alley\", false, \"Alien\", 890, { \"Aming\": \"Jake\", \"Hoon\": 234}, { \"Jack\": true } ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.nestedObject, 2)
    }
    
    func testStringDataCountWithNestedObjectInArray() throws {
        let data: String = "[ \"Napster\", \"Lemon\", \"Alley\", false, \"Alien\", 890, { \"Aming\": \"Jake\", \"Hoon\": 234}, { \"Jack\": true } ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.string, 4)
    }
    
    func testNumberDataCountWithNestedObjectInArray() throws {
        let data: String = "[ \"Napster\", \"Lemon\", \"Alley\", false, \"Alien\", 890, { \"Aming\": \"Jake\", \"Hoon\": 234}, { \"Jack\": true } ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.number, 1)
    }
    
    func testBoolDataCountWithNestedObjectInArray() throws {
        let data: String = "[ \"Napster\", \"Lemon\", \"Alley\", false, \"Alien\", 890, { \"Aming\": \"Jake\", \"Hoon\": 234}, { \"Jack\": true } ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.bool, 1)
    }
    
    func testValidationOfArrayWithNestedArray() throws {
        let data: String = "[ \"JK\" , 234 , true, [\"KIM JUNG\", 789, true, false], 890]"
        XCTAssertTrue(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWholeDataCountOfArrayWithNestedArray() throws {
        let data: String = "[ \"JK\" , 234 , true, [\"KIM JUNG\", 789, true, false], 890]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.count, 5)
    }
    
    func testNestedArrayDataCountInArray() throws {
        let data: String = "[ \"JK\" , 234 , true, [\"KIM JUNG\", 789, true, false], 890]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.nestedArray, 1)
    }
    
    func testStringDataCountWithNestedArrayInArray() throws {
        let data: String = "[ \"JK\" , 234 , true, [\"KIM JUNG\", 789, true, false], 890]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.string, 1)
    }
    
    func testNumberDataCountWithNestedArrayInArray() throws {
        let data: String = "[ \"JK\" , 234 , true, [\"KIM JUNG\", 789, true, false], 890]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.number, 2)
    }
    
    func testBoolDataCountWithNestedArrayInArray() throws {
        let data: String = "[ \"JK\" , 234 , true, [\"KIM JUNG\", 789, true, false], 890]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.bool, 1)
    }
    
    func testValidationOfArrayWithMultiNestedBlobs() throws {
        let data: String = "[ \"JK\", true, false, { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"nickname\":\"Pobi\",\"score\":4}, {\"slept\":true}, [\"Honux\",234,\"name\"], 3456 ]"
        XCTAssertTrue(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWholeDataCountWithMultiNestedBlobsInArray() throws {
        let data: String = "[ \"JK\", true, false, { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"nickname\":\"Pobi\",\"score\":4}, {\"slept\":true}, [\"Honux\",234,\"name\"], 3456 ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.count, 9)
    }
    
    func testNestedArrayCountWithMultiNestedBlobsInArray() throws {
        let data: String = "[ \"JK\", true, false, { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"nickname\":\"Pobi\",\"score\":4}, {\"slept\":true}, [\"Honux\",234,\"name\"], 3456 ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.nestedArray, 2)
    }
    
    func testNestedObjectCountWithMultiNestedBlobsInArray() throws {
        let data: String = "[ \"JK\", true, false, { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"nickname\":\"Pobi\",\"score\":4}, {\"slept\":true}, [\"Honux\",234,\"name\"], 3456 ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.nestedObject, 3)
    }
    
    func testStringDataCountWithMultiNestedBlobsInArray() throws {
        let data: String = "[ \"JK\", true, false, { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"nickname\":\"Pobi\",\"score\":4}, {\"slept\":true}, [\"Honux\",234,\"name\"], 3456 ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.string, 1)
    }
    
    func testNumberDataCountWithMultiNestedBlobsInArray() throws {
        let data: String = "[ \"JK\", true, false, { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"nickname\":\"Pobi\",\"score\":4}, {\"slept\":true}, [\"Honux\",234,\"name\"], 3456 ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.number, 1)
    }
    
    func testBoolDataCountWithMultiNestedBlobsInArray() throws {
        let data: String = "[ \"JK\", true, false, { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"nickname\":\"Pobi\",\"score\":4}, {\"slept\":true}, [\"Honux\",234,\"name\"], 3456 ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.bool, 2)
    }
    
    func testValidationOfObjectWithMultiNestedBlobs() throws {
        let data: String = "{ \"JK\":true, \"Alley\": 234, \"Lemon\":234, \"Aming\": {\"Alien\": \"Asdf\", \"Napster\": 324, \"Jake\":true }, \"Hoon\":[true, false, 234, \"Jack\"], \"Min\": false }"
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
        XCTAssertEqual(parsedData.dataCountOfEach.nestedArray, 1)
    }
    
    func testNestedObjectCountWithMultiNestedBlobsInObject() throws {
        let data: String = "{ \"JK\":true, \"Alley\": 234, \"Lemon\":234, \"Aming\": {\"Alien\": \"Asdf\", \"Napster\": 324, \"Jake\":true }, \"Hoon\":[true, false, 234, \"Jack\"], \"Min\": false }"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.nestedObject, 1)
    }
    
    func testStringCountWithMultiNestedBlobsInObject() throws {
        let data: String = "{ \"JK\":true, \"Alley\": 234, \"Lemon\":234, \"Aming\": {\"Alien\": \"Asdf\", \"Napster\": 324, \"Jake\":true }, \"Hoon\":[true, false, 234, \"Jack\"], \"Min\": false }"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.string, 0)
    }
    
    func testNumberCountWithMultiNestedBlobsInObject() throws {
        let data: String = "{ \"JK\":true, \"Alley\": 234, \"Lemon\":234, \"Aming\": {\"Alien\": \"Asdf\", \"Napster\": 324, \"Jake\":true }, \"Hoon\":[true, false, 234, \"Jack\"], \"Min\": false }"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.number, 2)
    }
    
    func testBoolCountWithMultiNestedBlobsInObject() throws {
        let data: String = "{ \"JK\":true, \"Alley\": 234, \"Lemon\":234, \"Aming\": {\"Alien\": \"Asdf\", \"Napster\": 324, \"Jake\":true }, \"Hoon\":[true, false, 234, \"Jack\"], \"Min\": false }"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.dataCountOfEach.bool, 2)
    }
    
    func testInvalidArrayPattern() throws {
        let data: String = "[ \"name\" : \"KIM JUNG\" ]"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testInvalidArrayPatternNestedOverTwoDepth() throws {
        let data: String = "[[\"JK\",\"KIM JUNG\", {\"level\":234} ],true,\"Honux\",false,324]"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testObjectKeyContainsWhitespace() throws {
        let data: String = "{\" whitespace\": true }"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWithoutCommaInObject() throws {
        let data: String = "{ \"comma\" : 234\"zero\":true}"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWithoutCommaInArray() throws {
        let data: String = "[ \"comma\"234, false]"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testWithNoOutermostBrackets() throws {
        let data: String = "\"brackets\":234,\"exist\":false"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testInvalidArrayDataInObject() throws {
        let data: String = "{ \"array\" : 324, [\"inObject\",234]}"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testRepeatedKeyInBasicObject() throws {
        let data: String = "{\"married\": true, \"married\": false}"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testRepeatedKeyInNestedObject() throws {
        let data: String = "{\"name\": \"JK\", \"married\": true, \"etc.\": {\"hobby\": \"take a photo\", \"hobby\": \"drawing\" }}"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testRepeatedKeyInNestedArray() throws {
        let data: String = "[\"JK\", true, {\"hobby\": \"take a photo\", \"hobby\": \"drawing\" }]"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testRepeatedKeyWithMultiNestedObjectsInArray() throws {
        let data: String = "[ { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, {\"name\":\"Pobi\",\"level\":4}, {\"married\":true}]"
        XCTAssertTrue(try GrammarChecker.isJSONPattern(data))
    }
    
    func testRepeatedKeyWithMultiNestedObjectsInObject() throws {
        let data: String = "{ \"JK\": {\"level\": 4, \"score\":234, \"skills\": true}, \"Pobi\": {\"level\": 4, \"score\": 234, \"skills\":true } }"
        XCTAssertTrue(try GrammarChecker.isJSONPattern(data))
    }
    
}
