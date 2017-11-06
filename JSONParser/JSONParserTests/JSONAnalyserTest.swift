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
        let testers = tester.trimmingCharacters(in: ["[","]"]).split(separator: ",").map({$0.trimmingCharacters(in: .whitespaces)})
        let jsonData = jsonAnalyser.getJsonData(items: testers)
        XCTAssertTrue(jsonData[0] is Int)
        XCTAssertTrue(jsonData[1] is String)
        XCTAssertTrue(jsonData[2] is Int)
        XCTAssertTrue(jsonData[3] is String)
        XCTAssertTrue(jsonData[4] is Int)
        XCTAssertTrue(jsonData[5] is String)
        XCTAssertTrue(jsonData[6] is Bool)
    }

}
