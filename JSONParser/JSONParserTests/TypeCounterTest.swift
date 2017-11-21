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
        var counterForArray : JSONArray = JSONArray()
        counterForArray.add(element: 10)
        counterForArray.add(element: "jk")
        counterForArray.add(element: 4)
        counterForArray.add(element: "314")
        counterForArray.add(element: 99)
        counterForArray.add(element: "crong")
        counterForArray.add(element: false)
        typeCounter = TypeCounter.init(jsonType: counterForArray)
        XCTAssertEqual(typeCounter?.boolCounter, 1)

        counterForArray.add(element: true)
        counterForArray.add(element: false)
        typeCounter = TypeCounter.init(jsonType: counterForArray)
        XCTAssertEqual(typeCounter?.boolCounter, 3)
    }

    func testCountType_intCounter() {
        var counterForArray : JSONArray = JSONArray()
        counterForArray.add(element: 10)
        counterForArray.add(element: "jk")
        counterForArray.add(element: 4)
        counterForArray.add(element: "314")
        counterForArray.add(element: 99)
        counterForArray.add(element: "crong")
        counterForArray.add(element: false)
        typeCounter = TypeCounter.init(jsonType: counterForArray)
        XCTAssertEqual(typeCounter?.intCounter, 3)

        counterForArray.add(element: 100)
        typeCounter = TypeCounter.init(jsonType: counterForArray)
        XCTAssertEqual(typeCounter?.intCounter, 4)
    }

    func testCountType_stringCounter() {
        var counterForArray : JSONArray = JSONArray()
        counterForArray.add(element: 10)
        counterForArray.add(element: "jk")
        counterForArray.add(element: 4)
        counterForArray.add(element: "314")
        counterForArray.add(element: 99)
        counterForArray.add(element: "crong")
        counterForArray.add(element: false)
        typeCounter = TypeCounter.init(jsonType: counterForArray)
        XCTAssertEqual(typeCounter?.stringCounter, 3)

        counterForArray.add(element: false)
        typeCounter = TypeCounter.init(jsonType: counterForArray)
        XCTAssertEqual(typeCounter?.stringCounter, 3)
    }
    
    func testCountObjectType_boolCounter() {
        var counterForObject : JSONObject = JSONObject()
        counterForObject.add(keyValue: (key: "name", value: "KIM JUNG"))
        counterForObject.add(keyValue: (key: "alias", value: "JK"))
        counterForObject.add(keyValue: (key: "level", value: 5))
        counterForObject.add(keyValue: (key: "married", value: true))
        typeCounter = TypeCounter.init(jsonType: counterForObject)
        XCTAssertEqual(typeCounter?.boolCounter, 1)

        counterForObject.add(keyValue: (key: "alias", value: false))
        typeCounter = TypeCounter.init(jsonType: counterForObject)
        XCTAssertEqual(typeCounter?.boolCounter, 2)
    }

    func testCountObjectType_intCounter() {
        var counterForObject : JSONObject = JSONObject()
        counterForObject.add(keyValue: (key: "name", value: "KIM JUNG"))
        counterForObject.add(keyValue: (key: "alias", value: "JK"))
        counterForObject.add(keyValue: (key: "level", value: 5))
        counterForObject.add(keyValue: (key: "married", value: true))
        typeCounter = TypeCounter.init(jsonType: counterForObject)
        XCTAssertEqual(typeCounter?.intCounter, 1)

        counterForObject.add(keyValue: (key: "name", value: "tester"))
        counterForObject.add(keyValue: (key: "alias", value: 200))
        counterForObject.add(keyValue: (key: "level", value: 5))
        counterForObject.add(keyValue: (key: "married", value: 2))
        typeCounter = TypeCounter.init(jsonType: counterForObject)
        XCTAssertEqual(typeCounter?.intCounter, 3)
    }

    func testCountObjectType_stringCounter() {
        var counterForObject : JSONObject = JSONObject()
        counterForObject.add(keyValue: (key: "name", value: "KIM JUNG"))
        counterForObject.add(keyValue: (key: "alias", value: "JK"))
        counterForObject.add(keyValue: (key: "level", value: 5))
        counterForObject.add(keyValue: (key: "married", value: true))
        typeCounter = TypeCounter.init(jsonType: counterForObject)
        XCTAssertEqual(typeCounter?.stringCounter, 2)

        counterForObject.add(keyValue: (key: "tester", value: "jake"))
        typeCounter = TypeCounter.init(jsonType: counterForObject)
        XCTAssertEqual(typeCounter?.stringCounter, 3)
    }
    
    func testCountTypeForNestedArray_objectCounter() {
        var counterForNestedArray : JSONArray = JSONArray()
        counterForNestedArray.add(element: ["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true, "children" : ["hana", "hayul", "haun"], "test" : ["test" : "tester"]])
        counterForNestedArray.add(element: [ 10, "jk", 4, "314", 99, "crong", false])
        typeCounter = TypeCounter.init(jsonType: counterForNestedArray)
        XCTAssertEqual(typeCounter?.objectCounter, 1)

        counterForNestedArray.add(element: ["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true])
        typeCounter = TypeCounter.init(jsonType: counterForNestedArray)
        XCTAssertEqual(typeCounter?.objectCounter, 2)
    }

    func testCountTypeForNestedArray_arrayCounter() {
        var counterForNestedArray : JSONArray = JSONArray()
        counterForNestedArray.add(element: ["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true, "children" : ["hana", "hayul", "haun"], "test" : ["test" : "tester"]])
        counterForNestedArray.add(element: [ 10, "jk", 4, "314", 99, "crong", false])
        typeCounter = TypeCounter.init(jsonType: counterForNestedArray)
        XCTAssertEqual(typeCounter?.arrayCounter, 1)

        counterForNestedArray.add(element: [ 10, "jk", 4, "314", 99, "crong", false])
        typeCounter = TypeCounter.init(jsonType: counterForNestedArray)
        XCTAssertEqual(typeCounter?.arrayCounter, 2)
    }
    
    func testCountTypeForNestedObject_stringCounter() {
        var counterForNestedObject : JSONObject = JSONObject()
        counterForNestedObject.add(keyValue: (key: "name", value: "KIM JUNG"))
        counterForNestedObject.add(keyValue: (key: "alias", value: "JK"))
        counterForNestedObject.add(keyValue: (key: "level", value: 5))
        counterForNestedObject.add(keyValue: (key: "married", value: true))
        counterForNestedObject.add(keyValue: (key: "children", value: ["hana", "hayul", "haun"]))
        counterForNestedObject.add(keyValue: (key: "test", value: ["test" : "tester"]))
        typeCounter = TypeCounter.init(jsonType: counterForNestedObject)
        XCTAssertEqual(typeCounter?.stringCounter, 2)

        counterForNestedObject.add(keyValue: (key: "tester1", value: "jake"))
        counterForNestedObject.add(keyValue: (key: "tester2", value: "jk"))
        typeCounter = TypeCounter.init(jsonType: counterForNestedObject)
        XCTAssertEqual(typeCounter?.stringCounter, 4)
    }

    func testCountTypeForNestedObject_intCounter() {
        var counterForNestedObject : JSONObject = JSONObject()
        counterForNestedObject.add(keyValue: (key: "name", value: "KIM JUNG"))
        counterForNestedObject.add(keyValue: (key: "alias", value: "JK"))
        counterForNestedObject.add(keyValue: (key: "level", value: 5))
        counterForNestedObject.add(keyValue: (key: "married", value: true))
        counterForNestedObject.add(keyValue: (key: "children", value: ["hana", "hayul", "haun"]))
        counterForNestedObject.add(keyValue: (key: "test", value: ["test" : "tester"]))
        typeCounter = TypeCounter.init(jsonType: counterForNestedObject)
        XCTAssertEqual(typeCounter?.intCounter, 1)

        counterForNestedObject.add(keyValue: (key: "tester1", value: 100))
        counterForNestedObject.add(keyValue: (key: "tester2", value: 2))
        counterForNestedObject.add(keyValue: (key: "tester3", value: "jake"))
        counterForNestedObject.add(keyValue: (key: "tester4", value: "jk"))
        counterForNestedObject.add(keyValue: (key: "tester5", value: 33))
        typeCounter = TypeCounter.init(jsonType: counterForNestedObject)
        XCTAssertEqual(typeCounter?.intCounter, 4)
    }

    func testCountTypeForNestedObject_boolCounter() {
        var counterForNestedObject : JSONObject = JSONObject()
        counterForNestedObject.add(keyValue: (key: "name", value: "KIM JUNG"))
        counterForNestedObject.add(keyValue: (key: "alias", value: "JK"))
        counterForNestedObject.add(keyValue: (key: "level", value: 5))
        counterForNestedObject.add(keyValue: (key: "married", value: true))
        counterForNestedObject.add(keyValue: (key: "children", value: ["hana", "hayul", "haun"]))
        counterForNestedObject.add(keyValue: (key: "test", value: ["test" : "tester"]))
        typeCounter = TypeCounter.init(jsonType: counterForNestedObject)
        XCTAssertEqual(typeCounter?.boolCounter, 1)

        counterForNestedObject.add(keyValue: (key: "tester1", value: 100))
        counterForNestedObject.add(keyValue: (key: "tester2", value: true))
        counterForNestedObject.add(keyValue: (key: "tester3", value: "jake"))
        counterForNestedObject.add(keyValue: (key: "tester4", value: "false"))
        counterForNestedObject.add(keyValue: (key: "tester5", value: false))
        typeCounter = TypeCounter.init(jsonType: counterForNestedObject)
        XCTAssertEqual(typeCounter?.boolCounter, 3)
    }

    func testCountTypeForNestedObject_arrayCounter() {
        var counterForNestedObject : JSONObject = JSONObject()
        counterForNestedObject.add(keyValue: (key: "name", value: "KIM JUNG"))
        counterForNestedObject.add(keyValue: (key: "alias", value: "JK"))
        counterForNestedObject.add(keyValue: (key: "level", value: 5))
        counterForNestedObject.add(keyValue: (key: "married", value: true))
        counterForNestedObject.add(keyValue: (key: "children", value: ["hana", "hayul", "haun"]))
        counterForNestedObject.add(keyValue: (key: "test", value: ["test" : "tester"]))
        typeCounter = TypeCounter.init(jsonType: counterForNestedObject)
        XCTAssertEqual(typeCounter?.arrayCounter, 1)

        counterForNestedObject.add(keyValue: (key: "tester1", value: 100))
        counterForNestedObject.add(keyValue: (key: "tester2", value: 2))
        counterForNestedObject.add(keyValue: (key: "tester3", value: ["jake", "jk"]))
        counterForNestedObject.add(keyValue: (key: "tester4", value: "jk"))
        counterForNestedObject.add(keyValue: (key: "tester5", value: 33))
        typeCounter = TypeCounter.init(jsonType: counterForNestedObject)
        XCTAssertEqual(typeCounter?.arrayCounter, 2)
    }

    func testCountTypeForNestedObject() {
        var counterForNestedObject : JSONObject = JSONObject()
        counterForNestedObject.add(keyValue: (key: "name", value: "KIM JUNG"))
        counterForNestedObject.add(keyValue: (key: "alias", value: "JK"))
        counterForNestedObject.add(keyValue: (key: "level", value: 5))
        counterForNestedObject.add(keyValue: (key: "married", value: true))
        counterForNestedObject.add(keyValue: (key: "children", value: ["hana", "hayul", "haun"]))
        counterForNestedObject.add(keyValue: (key: "test", value: ["test" : "tester"]))
        typeCounter = TypeCounter.init(jsonType: counterForNestedObject)
        XCTAssertEqual(typeCounter?.objectCounter, 1)

        counterForNestedObject.add(keyValue: (key: "tester1", value: 100))
        counterForNestedObject.add(keyValue: (key: "tester2", value: ["test" : "tester"]))
        counterForNestedObject.add(keyValue: (key: "tester3", value: ["jake", "jk"]))
        counterForNestedObject.add(keyValue: (key: "tester4", value: "jk"))
        counterForNestedObject.add(keyValue: (key: "tester5", value: ["33" : 33]))
        typeCounter = TypeCounter.init(jsonType: counterForNestedObject)
        XCTAssertEqual(typeCounter?.objectCounter, 3)
    }
    
    func testGetTotalCount() {
        var counterForArray : JSONArray = JSONArray()
        counterForArray.add(element: 10)
        counterForArray.add(element: "jk")
        counterForArray.add(element: 4)
        counterForArray.add(element: "314")
        counterForArray.add(element: 99)
        typeCounter = TypeCounter.init(jsonType: counterForArray)
        XCTAssertEqual(typeCounter?.totalCounter, 5)

        counterForArray.add(element: "crong")
        counterForArray.add(element: false)
        typeCounter = TypeCounter.init(jsonType: counterForArray)
        XCTAssertEqual(typeCounter?.totalCounter, 7)
    }
    
    func testGetTotalCountForObject() {
        var counterForObject : JSONObject = JSONObject()
        counterForObject.add(keyValue: (key: "name", value: "KIM JUNG"))
        counterForObject.add(keyValue: (key: "alias", value: "JK"))
        counterForObject.add(keyValue: (key: "level", value: 5))
        typeCounter = TypeCounter.init(jsonType: counterForObject)
        XCTAssertEqual(typeCounter?.totalCounter, 3)

        counterForObject.add(keyValue: (key: "married", value: true))
        typeCounter = TypeCounter.init(jsonType: counterForObject)
        XCTAssertEqual(typeCounter?.totalCounter, 4)
    }
    
    func testGetTotalCountForNestedArray() {
        var counterForNestedArray : JSONArray = JSONArray()
        counterForNestedArray.add(element: ["name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true, "children" : ["hana", "hayul", "haun"], "test" : ["test" : "tester"]])
        counterForNestedArray.add(element: [ 10, "jk", 4, "314", 99, "crong", false])
        typeCounter = TypeCounter.init(jsonType: counterForNestedArray)
        XCTAssertEqual(typeCounter?.totalCounter, 2)

        counterForNestedArray.add(element: [ 10, "jk", 4, "314", 99, "crong", false])
        typeCounter = TypeCounter.init(jsonType: counterForNestedArray)
        XCTAssertEqual(typeCounter?.totalCounter, 3)
    }
    
    func testGetTotalCountForNestedObject() {
        var counterForNestedObject : JSONObject = JSONObject()
        counterForNestedObject.add(keyValue: (key: "name", value: "KIM JUNG"))
        counterForNestedObject.add(keyValue: (key: "alias", value: "JK"))
        counterForNestedObject.add(keyValue: (key: "level", value: 5))
        counterForNestedObject.add(keyValue: (key: "married", value: true))
        counterForNestedObject.add(keyValue: (key: "children", value: ["hana", "hayul", "haun"]))
        counterForNestedObject.add(keyValue: (key: "test", value: ["test" : "tester"]))
        typeCounter = TypeCounter.init(jsonType: counterForNestedObject)
        XCTAssertEqual(typeCounter?.totalCounter, 6)

        counterForNestedObject.add(keyValue: (key: "tester1", value: 100))
        counterForNestedObject.add(keyValue: (key: "tester2", value: 2))
        counterForNestedObject.add(keyValue: (key: "tester3", value: ["jake", "jk"]))
        counterForNestedObject.add(keyValue: (key: "tester4", value: "jk"))
        counterForNestedObject.add(keyValue: (key: "tester5", value: 33))
        typeCounter = TypeCounter.init(jsonType: counterForNestedObject)
        XCTAssertEqual(typeCounter?.totalCounter, 11)
    }

}
