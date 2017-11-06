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
    var inputView : InputView?
    
    override func setUp() {
        super.setUp()
        typeCounter = TypeCounter()
        inputView = InputView()
    }
    
    override func tearDown() {
        super.tearDown()
        typeCounter = nil
        inputView = nil
    }

    func testCountType() {
        let testers : JsonData = [ 10, "jk", 4, "314", 99, "crong", false]
        typeCounter?.countTypes(items: testers)
        XCTAssertEqual(typeCounter?.boolCounter, 1)
        XCTAssertEqual(typeCounter?.intCounter, 3)
        XCTAssertEqual(typeCounter?.stringCounter, 3)
    }

}
