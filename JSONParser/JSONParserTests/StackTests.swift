//
//  StackTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class StackTests: XCTestCase {
    
    //GIVEN
    var stack = Stack<Int>()
    let firstElement = 1
    let secondElement = 2
    let lastElement = 3
    var beforeSize = 0
    override func setUp() {
        //GIVEN
        self.stack.push(firstElement)
        self.stack.push(secondElement)
        self.stack.push(lastElement)
        self.beforeSize = self.stack.size()
    }
    
    func testClear(){
        //WHEN
        self.stack.clear()
        //THEN
        XCTAssertTrue(self.stack.isEmpty())
    }
    
    func testIsEmptyTrue(){
        //GIVEN
        self.stack.clear()
        //THEN
        XCTAssertTrue(self.stack.isEmpty())
    }
    
    func testIsEmptyFalse(){
        //THEN
        XCTAssertFalse(self.stack.isEmpty())
    }
    
    func testPush(){
        //WHEN
        self.stack.push(4)
        //THEN
        XCTAssertEqual(self.stack.size(), self.beforeSize + 1)
    }
    
    func testPop(){
        //THEN
        XCTAssertEqual(try self.stack.pop(),self.lastElement)
        XCTAssertEqual(self.stack.size(),self.beforeSize-1)
    }
    
    func testPopThrowError(){
        //WHEN
        self.stack.clear()
        //THEN
        XCTAssertThrowsError(try self.stack.pop())
    }
    
    func testPeek(){
        //THEN
        XCTAssertEqual(self.beforeSize, self.stack.size())
        XCTAssertEqual(try self.stack.peek(),self.lastElement)
    }
    
    
    
}
