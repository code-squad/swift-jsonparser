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
    
    override func setUp() {
        super.setUp()
        typeCounter = TypeCounter()
    }
    
    override func tearDown() {
        super.tearDown()
        typeCounter = nil
    }

    func testCountType() {
        let testers : JSONData = [ 10, "jk", 4, "314", 99, "crong", false]
        typeCounter?.countTypes(items: testers)
        XCTAssertEqual(typeCounter?.boolCounter, 1)
        XCTAssertEqual(typeCounter?.intCounter, 3)
        XCTAssertEqual(typeCounter?.stringCounter, 3)
    }
    
    func testCountObjectType() {
        let tester : Dictionary<String, Any> = ["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true]
        let testers : JSONData = [tester]
        typeCounter?.countTypes(items: testers)
        XCTAssertEqual(typeCounter?.boolCounter, 1)
        XCTAssertEqual(typeCounter?.intCounter, 1)
        XCTAssertEqual(typeCounter?.stringCounter, 2)
    }
    
    func testGetTotalCount() {
        let testers : JSONData = [ 10, "jk", 4, "314", 99, "crong", false]
        typeCounter?.countTypes(items: testers)
        XCTAssertEqual(typeCounter?.getTotalCount(), 7)
    }
    
    func testGetTotalCountForObject() {
        let tester : Dictionary<String, Any> = ["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true]
        let testers : JSONData = [tester]
        typeCounter?.countTypes(items: testers)
        XCTAssertEqual(typeCounter?.getTotalCount(), 4)
    }

}
