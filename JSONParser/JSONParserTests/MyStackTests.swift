//
//  MyStackTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class MyStackTests: XCTestCase {
    //Given
    var stack = MyStack<Int>()
    let firstElement = 1
    let secondElement = 2
    let lastElement = 3
    var beforeSize = 0
    
    override func setUp() {
        //Given
        self.stack.push(firstElement)
        self.stack.push(secondElement)
        self.stack.push(lastElement)
        self.beforeSize = self.stack.size()
    }
    
    func testClear() {
        //When
        self.stack.clear()
        
        //Then
        XCTAssertTrue(self.stack.isEmpty())
    }
    
    func testIsEmptyTrue() {
        //Given
        self.stack.clear()
        
        //Then
        XCTAssertTrue(self.stack.isEmpty())
    }
    
    func testIsEmptyFalse() {
        //Then
        XCTAssertFalse(self.stack.isEmpty())
    }
    
    func testPush() {
        //When
        self.stack.push(4)
        
        //Then
        XCTAssertEqual(self.stack.size(), self.beforeSize + 1)
    }
    
    func testPop() {
        //Then
        XCTAssertEqual(self.stack.pop(),self.lastElement)
        XCTAssertEqual(self.stack.size(),self.beforeSize-1)
    }
    
    func testPopNil() {
        //When
        self.stack.clear()
        
        //Then
        XCTAssertNil(self.stack.pop())
    }
    
    func testPeek() {
        //Then
        XCTAssertEqual(self.beforeSize, self.stack.size())
        XCTAssertEqual(self.stack.peek(),self.lastElement)
    }

}
