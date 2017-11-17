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
    
    func testStringDataPatternInArray() throws {
        let data: String = "[ \"sdf\" , 234 , true ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.string, 1)
    }
    
    func testNumberDataPatternInArray() throws {
        let data: String = "[ \"sdf\" , 234 , true ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.number, 1)
    }
    
    func testBoolDataPatternInArray() throws {
        let data: String = "[ \"sdf\" , 234 , true ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.bool, 1)
    }
    
    func testNumberDataPatternInObject() throws {
        let data: String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\",\"level\":5,\"married\":true}"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.number, 1)
    }
    
    func testStringDataPatternInObject() throws {
        let data: String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\",\"level\":5,\"married\":true}"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.string, 2)
    }
    
    func testBoolDataPatternInObject() throws {
        let data: String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\",\"level\":5,\"married\":true}"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.bool, 1)
    }
    
    func testNestedObjectPatternInArray() throws {
        let data: String = "[{\"asdf\":\"asdf\",\"hrtdg\":234},{\"ertgf\":true}]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.nestedObject, 2)
    }
    
    func testNestedArrayPatternInArray() throws {
        let data: String = "[ \"sdf\" , 234 , true, [\"Sdf\", 234], 234]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.nestedArray, 1)
    }
    
    func testStringDataPatternWithNestedArrayInArray() throws {
        let data: String = "[ \"sdf\" , 234 , true, [\"Sdf\", 234], 234]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.string, 1)
    }
    
    func testNumberDataPatternWithNestedArrayInArray() throws {
        let data: String = "[ \"sdf\" , 234 , true, [\"Sdf\", 234], 234]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.number, 2)
    }
    
    func testBoolDataPatternWithNestedArrayInArray() throws {
        let data: String = "[ \"sdf\" , 234 , true, [\"Sdf\", 234], 234]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.bool, 1)
    }
    
    func testWholeDataCountWithMultiNestedBlobsInArray() throws {
        let data: String = "[ { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"asdf\":\"asdf\",\"hrtdg\":234}, {\"ertgf\":true}, [\"asdf\",234,\"ertgf\"] ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.count, 5)
    }
    
    func testNestedArrayPatternWithMultiNestedBlobsInArray() throws {
        let data: String = "[ { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"asdf\":\"asdf\",\"hrtdg\":234}, {\"ertgf\":true}, [\"asdf\",234,\"ertgf\"] ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.nestedArray, 2)
    }
    
    func testNestedObjectPatternWithMultiNestedBlobsInArray() throws {
        let data: String = "[ { \"name\" : \"KIMJUNG\", \"alias\":\"JK\",\"level\":5,\"married\":true}, [true,\"crong\",4,\"married\"], {\"asdf\":\"asdf\",\"hrtdg\":234}, {\"ertgf\":true}, [\"asdf\",234,\"ertgf\"] ]"
        let parsedData = try JSONParser.parse(data)
        XCTAssertEqual(parsedData.arrayCount.nestedObject, 3)
    }
    
    func testInvalidArrayType() throws {
        let data: String = "[ \"name\" : \"KIM JUNG\" ]"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testInvalidNestedArrayinObjectPattern() throws {
        let data: String = "{ \"sdf\":324,\"asdf\":{\"asdf\":234,\"asdf\":true}}"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testInvalid2DepthNestedPattern() throws {
        let data: String = "[[\"sdf\",\"sadf\", {\"Asdf\":234} ],true,\"sdf\",false,324]"
        XCTAssertFalse(try GrammarChecker.isJSONPattern(data))
    }
    
    func testObjectKeyWithWhitespace() throws {
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
