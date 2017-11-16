//
//  TypeCounterTest.swift
//  JSONParserTests
//
//  Created by TaeHyeonLee on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest

@testable import JSONParser

class TypeCounterTest: XCTestCase {
    var typeCounter : TypeCounter?
    let counterForArray : JSONData = [ 10, "jk", 4, "314", 99, "crong", false]
    let objectTester : JSONObject = ["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true]
    var counterForObject : JSONData!
    var counterForNestedArray : JSONData!
    let nestedObjectTester : JSONObject = ["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true, "children" : ["hana", "hayul", "haun"], "test" : ["test" : "tester"]]
    var counterForNestedObject : JSONData!
    
    override func setUp() {
        super.setUp()
        counterForObject = [objectTester]
        counterForNestedArray = [objectTester, counterForArray]
        counterForNestedObject = [nestedObjectTester]
    }
    
    override func tearDown() {
        super.tearDown()
        typeCounter = nil
    }

    func testCountType() {
        typeCounter = TypeCounter.init(jsonData: counterForArray)
        XCTAssertEqual(typeCounter?.boolCounter, 1)
        XCTAssertEqual(typeCounter?.intCounter, 3)
        XCTAssertEqual(typeCounter?.stringCounter, 3)
    }
    
    func testCountObjectType() {
        typeCounter = TypeCounter.init(jsonData: counterForObject)
        XCTAssertEqual(typeCounter?.boolCounter, 1)
        XCTAssertEqual(typeCounter?.intCounter, 1)
        XCTAssertEqual(typeCounter?.stringCounter, 2)
    }
    
    func testCountTypeForNestedArray() {
        typeCounter = TypeCounter.init(jsonData: counterForNestedArray)
        XCTAssertEqual(typeCounter?.objectCounter, 1)
        XCTAssertEqual(typeCounter?.arrayCounter, 1)
    }
    
    func testCountTypeForNestedObject() {
        typeCounter = TypeCounter.init(jsonData: counterForNestedObject)
        XCTAssertEqual(typeCounter?.stringCounter, 2)
        XCTAssertEqual(typeCounter?.intCounter, 1)
        XCTAssertEqual(typeCounter?.boolCounter, 1)
        XCTAssertEqual(typeCounter?.arrayCounter, 1)
        XCTAssertEqual(typeCounter?.objectCounter, 1)
    }
    
    func testGetTotalCount() {
        typeCounter = TypeCounter.init(jsonData: counterForArray)
        XCTAssertEqual(typeCounter?.totalCounter, 7)
    }
    
    func testGetTotalCountForObject() {
        typeCounter = TypeCounter.init(jsonData: counterForObject)
        XCTAssertEqual(typeCounter?.totalCounter, 4)
    }
    
    func testGetTotalCountForNestedArray() {
        typeCounter = TypeCounter.init(jsonData: counterForNestedArray)
        XCTAssertEqual(typeCounter?.totalCounter, 2)
    }
    
    func testGetTotalCountForNestedObject() {
        typeCounter = TypeCounter.init(jsonData: counterForNestedObject)
        XCTAssertEqual(typeCounter?.totalCounter, 6)
    }

}
