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
    
    override func setUp() {
        super.setUp()
        counterForObject = [self.objectTester]
        counterForNestedArray = [self.objectTester, self.counterForArray]
    }
    
    override func tearDown() {
        super.tearDown()
        typeCounter = nil
    }

    func testCountType() {
        typeCounter = TypeCounter.init(items: counterForArray)
        XCTAssertEqual(typeCounter?.boolCounter, 1)
        XCTAssertEqual(typeCounter?.intCounter, 3)
        XCTAssertEqual(typeCounter?.stringCounter, 3)
    }
    
    func testCountObjectType() {
        typeCounter = TypeCounter.init(items: counterForObject)
        XCTAssertEqual(typeCounter?.boolCounter, 1)
        XCTAssertEqual(typeCounter?.intCounter, 1)
        XCTAssertEqual(typeCounter?.stringCounter, 2)
    }
    
    func testCountTypeForNestedArray() {
        typeCounter = TypeCounter.init(items: counterForNestedArray)
        XCTAssertEqual(typeCounter?.objectCounter, 1)
        XCTAssertEqual(typeCounter?.arrayCounter, 1)
    }
    
    func testGetTotalCount() {
        typeCounter = TypeCounter.init(items: counterForArray)
        XCTAssertEqual(typeCounter?.getTotalCount(), 7)
    }
    
    func testGetTotalCountForObject() {
        typeCounter = TypeCounter.init(items: counterForObject)
        XCTAssertEqual(typeCounter?.getTotalCount(), 4)
    }
    
    func testGetTotalCountForNestedArray() {
        typeCounter = TypeCounter.init(items: counterForNestedArray)
        XCTAssertEqual(typeCounter?.getTotalCount(), 2)
    }

}
