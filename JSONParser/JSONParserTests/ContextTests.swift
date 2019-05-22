//
//  ContextTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 21/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class ContextTests: XCTestCase {
    
    //GIVEN
    let containerContext = Context.Array
    let elementContext = Context.Value
    let stringContext = Context.String
    
    func testContainerContextEnd(){
        //THEN
        XCTAssertTrue(self.containerContext.isEnd("]"))
    }
    
    func testStringContextEnd(){
        //THEN
        XCTAssertTrue(self.stringContext.isEnd("\""))
        XCTAssertFalse(self.stringContext.isEnd(" "))
    }
    
    func testElementContextEnd(){
        //THEN
        XCTAssertTrue(self.elementContext.isEnd(","))
        XCTAssertTrue(self.elementContext.isEnd("]"))
    }
    
    func testContainerContextStart(){
        //THEN
        XCTAssertTrue(self.containerContext.isStart(" "))
    }
    
    func testStringContextStart(){
        //THEN
        XCTAssertFalse(self.stringContext.isStart(" "))
        XCTAssertFalse(self.stringContext.isStart(","))
    }
    
    func testElementContextStart(){
        //THEN
        XCTAssertTrue(self.elementContext.isStart("\""))
    }
}


