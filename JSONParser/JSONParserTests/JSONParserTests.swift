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
    let parsedData: [Any] = [10, "jk", 4, "314", 99, "crong", false]
    
    func testParsingJSONData() {
        do {
            try JSONData.parse(from: jsonString)
        }catch {
            XCTAssertNoThrow(error, error.localizedDescription)
        }
    }

    func testJSONObjectIsNotNil() {
        let jsonData = JSONData.init(parsedData)
        XCTAssertNotNil(jsonData)
    }

    func testCountOfNumberIsRight() {
        let jsonData = JSONData.init(parsedData)
        XCTAssertEqual(jsonData.number.count, 3)
    }
    
    func testCountOfStringIsRight() {
        let jsonData = JSONData.init(parsedData)
        XCTAssertEqual(jsonData.string.count, 3)
    }
    
    func testCountOfBoolIsRight() {
        let jsonData = JSONData.init(parsedData)
        XCTAssertEqual(jsonData.bool.count, 1)
    }
   
}
