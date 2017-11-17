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
    }
    
    override func tearDown() {
        super.tearDown()
        typeCounter = nil
    }

    func testCountType_boolCounter() {
        var counterForArray : JSONData = [ 10, "jk", 4, "314", 99, "crong", false]
        typeCounter = TypeCounter.init(jsonData: counterForArray)
        XCTAssertEqual(typeCounter?.boolCounter, 1)

        counterForArray = [ 10, true, 4, "314", false, "crong", false]
        typeCounter = TypeCounter.init(jsonData: counterForArray)
        XCTAssertEqual(typeCounter?.boolCounter, 3)
    }

    func testCountType_intCounter() {
        var counterForArray : JSONData = [ 10, "jk", 4, "314", 99, "crong", false]
        typeCounter = TypeCounter.init(jsonData: counterForArray)
        XCTAssertEqual(typeCounter?.intCounter, 3)

        counterForArray = [ 10, "jk", 4, 314, 99, "crong", false]
        typeCounter = TypeCounter.init(jsonData: counterForArray)
        XCTAssertEqual(typeCounter?.intCounter, 4)
    }

    func testCountType_stringCounter() {
        var counterForArray : JSONData = [ 10, "jk", 4, "314", 99, "crong", false]
        typeCounter = TypeCounter.init(jsonData: counterForArray)
        XCTAssertEqual(typeCounter?.stringCounter, 3)

        counterForArray = [ 10, "jk", 4, 314, 99, "crong", "false"]
        typeCounter = TypeCounter.init(jsonData: counterForArray)
        XCTAssertEqual(typeCounter?.stringCounter, 3)
    }
    
    func testCountObjectType_boolCounter() {
        var counterForObject = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true]]
        typeCounter = TypeCounter.init(jsonData: counterForObject)
        XCTAssertEqual(typeCounter?.boolCounter, 1)

        counterForObject = [["name" : "true", "alias" : false, "level" : 5, "married" : true]]
        typeCounter = TypeCounter.init(jsonData: counterForObject)
        XCTAssertEqual(typeCounter?.boolCounter, 2)
    }

    func testCountObjectType_intCounter() {
        var counterForObject = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true]]
        typeCounter = TypeCounter.init(jsonData: counterForObject)
        XCTAssertEqual(typeCounter?.intCounter, 1)
        counterForObject = [["name" : 33, "alias" : 200, "level" : 5, "married" : true]]
        typeCounter = TypeCounter.init(jsonData: counterForObject)
        XCTAssertEqual(typeCounter?.intCounter, 3)
    }

    func testCountObjectType_stringCounter() {
        var counterForObject = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true]]
        typeCounter = TypeCounter.init(jsonData: counterForObject)
        XCTAssertEqual(typeCounter?.stringCounter, 2)
        counterForObject = [["name" : "Taehyeon", "alias" : "jake", "level" : 5, "married" : "false"]]
        typeCounter = TypeCounter.init(jsonData: counterForObject)
        XCTAssertEqual(typeCounter?.stringCounter, 3)
    }
    
    func testCountTypeForNestedArray_objectCounter() {
        var counterForNestedArray: JSONData = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true, "children" : ["hana", "hayul", "haun"], "test" : ["test" : "tester"]], [ 10, "jk", 4, "314", 99, "crong", false]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedArray)
        XCTAssertEqual(typeCounter?.objectCounter, 1)

        counterForNestedArray = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true], ["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedArray)
        XCTAssertEqual(typeCounter?.objectCounter, 2)
    }

    func testCountTypeForNestedArray_arrayCounter() {
        var counterForNestedArray: JSONData = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true, "children" : ["hana", "hayul", "haun"], "test" : ["test" : "tester"]], [ 10, "jk", 4, "314", 99, "crong", false]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedArray)
        XCTAssertEqual(typeCounter?.arrayCounter, 1)

        counterForNestedArray = [[ 10, "jk", 4, "314", 99, "crong", false], [ 10, "jk", 4, "314", 99, "crong", false]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedArray)
        XCTAssertEqual(typeCounter?.arrayCounter, 2)
    }
    
    func testCountTypeForNestedObject_stringCounter() {
        var counterForNestedObject : JSONData = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true, "children" : ["hana", "hayul", "haun"], "test" : ["test" : "tester"]]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedObject)
        XCTAssertEqual(typeCounter?.stringCounter, 2)

        counterForNestedObject = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true, "children" : "jk", "test" : "jake"]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedObject)
        XCTAssertEqual(typeCounter?.stringCounter, 4)
    }

    func testCountTypeForNestedObject_intCounter() {
        var counterForNestedObject : JSONData = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true, "children" : ["hana", "hayul", "haun"], "test" : ["test" : "tester"]]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedObject)
        XCTAssertEqual(typeCounter?.intCounter, 1)

        counterForNestedObject = [["name" : 3, "alias" : "JK", "level" : 5, "married" : true, "children" : 4, "test" : 1]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedObject)
        XCTAssertEqual(typeCounter?.intCounter, 4)
    }

    func testCountTypeForNestedObject_boolCounter() {
        var counterForNestedObject : JSONData = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true, "children" : ["hana", "hayul", "haun"], "test" : ["test" : "tester"]]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedObject)
        XCTAssertEqual(typeCounter?.boolCounter, 1)

        counterForNestedObject = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true, "children" : false, "test" : true]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedObject)
        XCTAssertEqual(typeCounter?.boolCounter, 3)
    }

    func testCountTypeForNestedObject_arrayCounter() {
        var counterForNestedObject : JSONData = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true, "children" : ["hana", "hayul", "haun"], "test" : ["test" : "tester"]]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedObject)
        XCTAssertEqual(typeCounter?.arrayCounter, 1)

        counterForNestedObject = [["name" : "KIM JUNG", "level" : 5, "married" : true, "children" : ["hana", "hayul", "haun"], "test" : ["test", "tester"]]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedObject)
        XCTAssertEqual(typeCounter?.arrayCounter, 2)
    }

    func testCountTypeForNestedObject() {
        var counterForNestedObject : JSONData = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true, "children" : ["hana", "hayul", "haun"], "test" : ["test" : "tester"]]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedObject)
        XCTAssertEqual(typeCounter?.objectCounter, 1)

        counterForNestedObject = [["name" : ["KIM JUNG": 1], "level" : 5, "married" : true, "children" : ["hana": "hayul"], "test" : ["test" : "tester"]]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedObject)
        XCTAssertEqual(typeCounter?.objectCounter, 3)
    }
    
    func testGetTotalCount() {
        var counterForArray : JSONData = [ 10, "jk", 4, "314", 99, "crong", false]
        typeCounter = TypeCounter.init(jsonData: counterForArray)
        XCTAssertEqual(typeCounter?.totalCounter, 7)

        counterForArray = [ 10, "jk", 4, "314", 99, "crong"]
        typeCounter = TypeCounter.init(jsonData: counterForArray)
        XCTAssertEqual(typeCounter?.totalCounter, 6)
    }
    
    func testGetTotalCountForObject() {
        var counterForObject = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true]]
        typeCounter = TypeCounter.init(jsonData: counterForObject)
        XCTAssertEqual(typeCounter?.totalCounter, 4)

        counterForObject = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5]]
        typeCounter = TypeCounter.init(jsonData: counterForObject)
        XCTAssertEqual(typeCounter?.totalCounter, 3)
    }
    
    func testGetTotalCountForNestedArray() {
        var counterForNestedArray: JSONData = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true, "children" : ["hana", "hayul", "haun"], "test" : ["test" : "tester"]], [ 10, "jk", 4, "314", 99, "crong", false]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedArray)
        XCTAssertEqual(typeCounter?.totalCounter, 2)

        counterForNestedArray = [["name" : "KIM JUNG", "children" : ["hana", "hayul", "haun"], "test" : ["test" : "tester"]], [ 10, "jk", 4, "314", 99, "crong", false], [ 10, "jk", 4, "314", 99, "crong"]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedArray)
        XCTAssertEqual(typeCounter?.totalCounter, 3)
    }
    
    func testGetTotalCountForNestedObject() {
        var counterForNestedObject : JSONData = [["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true, "children" : ["hana", "hayul", "haun"], "test" : ["test" : "tester"]]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedObject)
        XCTAssertEqual(typeCounter?.totalCounter, 6)

        counterForNestedObject = [["name" : "KIM JUNG", "children" : ["hana", "hayul", "haun"], "test" : ["test" : "tester"]]]
        typeCounter = TypeCounter.init(jsonData: counterForNestedObject)
        XCTAssertEqual(typeCounter?.totalCounter, 3)
    }

}
