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
    var testers : JSONData!
    let objectTester : Dictionary<String, Any> = ["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true]
    
    override func setUp() {
        super.setUp()
        testers = [ 10, "jk", 4, "314", 99, "crong", false]
    }
    
    override func tearDown() {
        super.tearDown()
        typeCounter = nil
    }

    func testCountType() {
        typeCounter = TypeCounter.init(items: testers)
        XCTAssertEqual(typeCounter?.boolCounter, 1)
        XCTAssertEqual(typeCounter?.intCounter, 3)
        XCTAssertEqual(typeCounter?.stringCounter, 3)
    }
    
    func testCountObjectType() {
        testers = [objectTester]
        typeCounter = TypeCounter.init(items: testers)
        XCTAssertEqual(typeCounter?.boolCounter, 1)
        XCTAssertEqual(typeCounter?.intCounter, 1)
        XCTAssertEqual(typeCounter?.stringCounter, 2)
    }
    
    func testGetTotalCount() {
        typeCounter = TypeCounter.init(items: testers)
        XCTAssertEqual(typeCounter?.getTotalCount(), 7)
    }
    
    func testGetTotalCountForObject() {
        testers = [objectTester]
        typeCounter = TypeCounter.init(items: testers)
        XCTAssertEqual(typeCounter?.getTotalCount(), 4)
    }

}
