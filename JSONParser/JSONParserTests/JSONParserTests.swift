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
    
    func testParsingJSONData() {
        do {
            let jsonString: String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
            try JSONParser.parse(from: jsonString)
        }catch {
            XCTAssertNoThrow(error, error.localizedDescription)
        }
    }

    func testJSONObjectIsNotNil() {
        let jsonString: String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let parsedData = try JSONParser.parse(from: jsonString)
        XCTAssertNotNil(parsedData)
    }

    func testCountOfNumberIsRight() {
        let jsonString: String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let parsedData = try JSONParser.parse(from: jsonString)
        XCTAssertEqual(parsedData.number.count, 3)
    }
    
    func testCountOfStringIsRight() {
        let jsonString: String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let parsedData = try JSONParser.parse(from: jsonString)
        XCTAssertEqual(parsedData.string.count, 3)
    }
    
    func testCountOfBoolIsRight() {
        let jsonString: String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let parsedData = try JSONParser.parse(from: jsonString)
        XCTAssertEqual(parsedData.bool.count, 1)
    }
   
}
