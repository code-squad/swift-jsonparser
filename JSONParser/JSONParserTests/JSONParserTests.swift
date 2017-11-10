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
    
    func testParsingJSONData() throws {
        let jsonString: String = "{\"name\":\"KIM JUNG\",\"alias\":\"JK\",\"level\":5,\"married\":true}"
        XCTAssertNotNil(try JSONParser.parse(jsonString))
    }
    
    func testStringDataIsNotNil() {
        let parsedData = JSONData(["name":"KIM JUNG"], ofType: .array)
        XCTAssertNotNil(parsedData)
    }
    
    func testNumberDataIsNotNil() {
        let parsedData = JSONData(["level" :5], ofType: .array)
        XCTAssertNotNil(parsedData)
    }
    
    func testBoolDataIsNotNil() {
        let parsedData = JSONData(["married": true], ofType: .array)
        XCTAssertNotNil(parsedData)
    }
    
    func testCountOfNumberIsRight() throws {
        let jsonString: String = "{\"name\":\"KIM JUNG\",\"alias\":\"JK\",\"level\":5,\"married\":true}"
        let parsedData = try JSONParser.parse(jsonString)
        XCTAssertEqual(parsedData[0].number.count, 1)
        XCTAssertEqual(parsedData[0].string.count, 2)
        XCTAssertEqual(parsedData[0].bool.count, 1)
    }
    
    func testCountOfAnArrayIsRight() throws {
        let jsonString: String = "{\"name\":\"KIMJUNG\",\"alias\":\"JK\",\"level\":5,\"married\":true}"
        let parsedData = try JSONParser.parse(jsonString)
        XCTAssertEqual(parsedData.count, 1)
    }
    
    func testCountOfAnObjectIsRight() throws {
        let jsonString: String = "[\"asdf\":\"asdf\",\"hrtdg\":234,\"ertgf\":true]"
        let parsedData = try JSONParser.parse(jsonString)
        XCTAssertEqual(parsedData.count, 1)
    }
    
    func testCountOfArraysIsRight() throws {
        let jsonString: String = "{\"asdf\":\"asdf\",\"hrtdg\":234},{\"ertgf\":true}"
        let parsedData = try JSONParser.parse(jsonString)
        XCTAssertEqual(parsedData.count, 2)
    }
    
    func testCountOfObjectsIsRight() throws {
        let jsonString: String = "[\"asdf\":\"asdf\",\"hrtdg\":234],[\"ertgf\":true]],[\"ertgf\":23456]"
        let parsedData = try JSONParser.parse(jsonString)
        XCTAssertEqual(parsedData.count, 3)
    }
    
    func testCountOfObjectsAndArraysIsRight() throws {
        let jsonString: String = "{\"name\":\"KIMJUNG\",\"alias\":\"JK\",\"level\":5,\"married\":true},[\"name\":\"YOONJISU\",\"alias\":\"crong\",\"level\":4,\"married\":true],{\"asdf\":\"asdf\",\"hrtdg\":234},{\"ertgf\":true},[\"asdf\":\"asdf\",\"hrtdg\":234,\"ertgf\":true]"
        let parsedData = try JSONParser.parse(jsonString)
        var arrayCount = 0
        var objectCount = 0
        for data in parsedData {
            switch data.type {
            case .array: arrayCount += 1
            case .object: objectCount += 1
            }
        }
        XCTAssertEqual(arrayCount, 3)
        XCTAssertEqual(objectCount, 2)
    }
    
}
