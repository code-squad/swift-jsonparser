//
//  JSONParserTests.swift
//  JSONParserTests
//
//  Created by yuaming on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest

class JSONParserTests: XCTestCase {
    typealias DataTypeName = JSONData.TypeName
    
    func test_JSONData_배열_요소_분리_확인() {
        let inputValue = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        XCTAssertTrue(Utility.removeFromFirstToEnd(in: inputValue).split().count == 7)
    }
    
    func test_JSONData_배열_요소_개수_확인() {
        let inputValue = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).boolCount == 1)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).numberCount == 3)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).stringCount  == 3)
    }
    
    func test_JSONData_배열_빈값_오류발생_확인() {
        let inputValue = "[]"
        XCTAssertThrowsError(try JSONParser.analyzeJSONData(in: inputValue))
    }
}
