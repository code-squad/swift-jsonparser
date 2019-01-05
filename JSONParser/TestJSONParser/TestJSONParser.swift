//
//  TestJSONParser.swift
//  TestJSONParser
//
//  Created by Elena on 20/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest
@testable import JSONParser

class TestJSONParser: XCTestCase {

    override func setUp() { }
    override func tearDown() { }

    //Parser
    // Valid Data
    func testParserisValidData() {
        let validData = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertTrue(Parser.isDivideData(from: validData))
    }
    // Open Bracket X
    func testParserisNoOpenBracket() {
        let noOpenBracket = " \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertFalse(Parser.isDivideData(from: noOpenBracket))
    }
    // Close Bracket X
    func testParserisNoCloseBracket() {
        let noCloseBracket = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true "
        XCTAssertFalse(Parser.isDivideData(from: noCloseBracket))
    }
    
    //Array Valid Data
    func testArrayParserisValidData() {
        let validData = "[{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true },{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }]"
        XCTAssertTrue(Parser.isDivideData(from: validData))
    }
    // JSONType Object check
    func testJSONTypeObjectValidData() {
        let dic: [String: JSONType] = ["name" : JSONType.string("kwangrae"), "alias" : JSONType.string("cony"), "level" : JSONType.int(2), "married" : JSONType.bool(false)]
        let jsonObject = ParserObject.init(dic)
        XCTAssertEqual(jsonObject.printType(), ["문자열": 2, "숫자": 1, "부울": 1])
    }
    // JSONType Array check
    func testJSONTypeArrayValidData() {
        let array = [JSONType.string("kwangrae"), JSONType.string("cony"), JSONType.int(2), JSONType.bool(false)]
        let jsonArray = ParserArray.init(array)
        XCTAssertEqual(jsonArray.printType(), ["문자열": 2, "숫자": 1, "부울": 1])
    }
    // JSONType select check : String
    func testJSONTypeStringValidData() {
        let inputString = "\"conyconydev\""
        let selectString = JSONTypeSelect.selectJSONData(inputString)
        let equalStringType = JSONType.string(inputString)
        XCTAssertEqual(selectString?.typeName,equalStringType.typeName)
    }
    // JSONType select check : Bool
    func testJSONTypeBoolValidData() {
        let inputData = "true"
        let selectBool = JSONTypeSelect.selectJSONData(inputData)
        let equalStringType = JSONType.bool(true)
        XCTAssertEqual(selectBool?.typeName,equalStringType.typeName)
    }
    // JSONType select check : Int
    func testJSONTypeIntValidData() {
        let inputData = "55"
        let selectInt = JSONTypeSelect.selectJSONData(inputData)
        let equalStringType = JSONType.int(55)
        XCTAssertEqual(selectInt?.typeName,equalStringType.typeName)
    }
    
}
