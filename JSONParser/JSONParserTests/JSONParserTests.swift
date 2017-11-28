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
        let inputValue = """
        [ 10, "jk", 4, "314", 99, "crong", false ]
        """
        XCTAssertTrue(Utility.removeFromFirstToEnd(in: inputValue).splitUnits().count == 7)
    }
    
    func test_JSONData_배열_요소_개수_확인() {
        let inputValue = """
        [ 10, "jk", 4, "314", 99, "crong", false ]
        """
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).boolCount == 1)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).numberCount == 3)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).stringCount  == 3)
    }
    
    func test_JSONData_배열_안_객체_개수_확인() {
        let inputValue = """
            [ { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true },
           { "name" : "YOON JISU", "alias" : "crong", "level" : 4, "married" : true } ]
        """
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).objectCount == 2)
    }
    
    func test_JSONData_객체_요소_분리_확인() {
        let inputValue = """
        { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true }
        """
        XCTAssertTrue(Utility.removeFromFirstToEnd(in: inputValue).splitUnits().count == 4)
    }
    
    func test_JSONData_객체_요소_개수_확인() {
        let inputValue = """
        { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true }
        """
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).boolCount == 1)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).numberCount == 1)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).stringCount  == 2)
    }
}
