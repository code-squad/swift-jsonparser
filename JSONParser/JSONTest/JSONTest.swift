//
//  JSONTest.swift
//  JSONTest
//
//  Created by Yoda Codd on 2018. 5. 24..
//  Copyright © 2018년 JK. All rights reserved.
//

import XCTest

class JSONTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let str = "\"as,34\""
        let k = Checker.isLettersForJSON(letter: str)
        XCTAssert(k)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
