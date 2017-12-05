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
    
    func test_JSONData_배열_요소_개수_확인() {
        let inputValue = """
        [ 10, "jk", 4, "314", 99, "crong", true ]
        """
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).totalCount == 7)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).boolCount == 1)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).numberCount == 3)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).stringCount  == 3)
    }
    
    func test_JSONData_배열_안_객체_개수_확인() {
        let inputValue = """
        [ true, { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true }, { "name" : "YOON JISU", "alias" : "crong", "level" : 4, "married" : true } ]
        """
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).totalCount == 3)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).objectCount == 2)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).boolCount == 1)
    }
    
    func test_JSONData_배열_안_객체_안_배열_개수_확인() {
        let inputValue = """
        [ true, { "name" : "KIM JUNG", "alias" : "JK", "level" : [5, 4, 3], "married" : true }, { "name" : "YOON JISU", "alias" : "crong", "level" : 4, "married" : true } ]
        """
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).totalCount == 3)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).objectCount == 2)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).boolCount == 1)
    }
    
    
    func test_JSONData_객체_요소_개수_확인() {
        let inputValue = """
        { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true }
        """
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).totalCount == 4)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).boolCount == 1)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).numberCount == 1)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).stringCount  == 2)
    }
    
    func test_JSONData_객체_안_배열_개수_확인() {
        let inputValue = """
        { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "children" : ["hana", "hayul", "haun"], "married" :true }
        """
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).totalCount == 5)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).boolCount == 1)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).numberCount == 1)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).stringCount  == 2)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).arrayCount  == 1)
    }
    
    func test_JSONData_배열_안_객체와배열_개수_확인() {
        let inputValue = """
        [ { "name" : "master's course", "opened" : true }, [ "java", "javascript", "swift" ] ]
        """
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).totalCount == 2)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).objectCount == 1)
        XCTAssertTrue(try JSONParser.analyzeJSONData(in: inputValue).arrayCount  == 1)
    }
}
