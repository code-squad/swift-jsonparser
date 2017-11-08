//
//  JSONAnalyserTest.swift
//  JSONParserTests
//
//  Created by TaeHyeonLee on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest

@testable import JSONParser

class JSONAnalyserTest: XCTestCase {
    var jsonAnalyser : JSONAnalyser!
    
    override func setUp() {
        super.setUp()
        jsonAnalyser = JSONAnalyser()
    }
    
    override func tearDown() {
        super.tearDown()
        jsonAnalyser = nil
    }

    func testGetJsonData() {
        let tester : String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let jsonData = jsonAnalyser.getJSONData(items: tester.getElements())
        XCTAssertTrue(jsonData[0] is Int)
        XCTAssertTrue(jsonData[1] is String)
        XCTAssertTrue(jsonData[2] is Int)
        XCTAssertTrue(jsonData[3] is String)
        XCTAssertTrue(jsonData[4] is Int)
        XCTAssertTrue(jsonData[5] is String)
        XCTAssertTrue(jsonData[6] is Bool)
    }
    
    func testGetObjectType() {
        let tester : String = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertEqual(tester.getElementsForObject().count, 4)
        let object = jsonAnalyser.getObjectType(items: tester.getElementsForObject())
        XCTAssertEqual(object.count, 4)
        XCTAssertEqual(object["name"] as! String, "KIM JUNG")
        XCTAssertEqual(object["alias"] as! String, "JK")
        XCTAssertEqual(object["level"] as! Int, 5)
        XCTAssertEqual(object["married"] as! Bool, true)
    }

}
