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
    let jsonString: String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
    var parsedData: JSONData!
    
    override func setUp() {
        parsedData = JSONParser.parse(from: jsonString)
    }
    
    override func tearDown() {
        parsedData = nil
    }
    
    func testParsingJSONData() {
        do {
            try JSONParser.parse(from: jsonString)
        }catch {
            XCTAssertNoThrow(error, error.localizedDescription)
        }
    }

    func testJSONObjectIsNotNil() {
        XCTAssertNotNil(parsedData)
    }

    func testCountOfNumberIsRight() {
        XCTAssertEqual(parsedData.number.count, 3)
    }
    
    func testCountOfStringIsRight() {
        XCTAssertEqual(parsedData.string.count, 3)
    }
    
    func testCountOfBoolIsRight() {
        XCTAssertEqual(parsedData.bool.count, 1)
    }
   
}
