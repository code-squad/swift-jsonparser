//
//  JSONParserTests.swift
//  JSONParserTests
//
//  Created by yuaming on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest

@testable import JSONParser

class JSONParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
 
    func test_입력받은_데이터_분리() {
        let inputValue = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        XCTAssertTrue(Utility.removeFromFirstToEnd(in: inputValue).split().count == 7)
    }
    
    func test_분리한_데이터_타입_확인() {
        typealias DataTypeName = JSONDataType.TypeName
        
        let inputValue = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).getJSONDataType[DataTypeName.boolean.rawValue] == 1)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).getJSONDataType[DataTypeName.number.rawValue]  == 3)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).getJSONDataType[DataTypeName.string.rawValue]  == 3)
    }
    
    func test_빈값_오류_확인() {
        let inputValue = "[]"
        XCTAssertThrowsError(try JSONParser.analyzeJSONData(in: inputValue))
    }
}
