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
    let arrayContext = Context.Array
    let valueContext = Context.Value
    let stringContext = Context.String
    
    func testArrayontextStart(){
        //WHEN
        guard let context = Context.init(rawValue: "[") else { return }
        //THEN
        XCTAssertTrue(self.arrayContext.canInclude(context: context))
    }
    
    func testArrayContextEnd(){
        //THEN
        XCTAssertTrue(self.arrayContext.isFinish(inCaseOf: "]"))
    }
    func testStringContextStart(){
        //WHEN
        guard let context = Context.init(rawValue: "\"") else { return }
        //THEN
        XCTAssertTrue(self.valueContext.canInclude(context: context))
    }
    
    func testStringContextEnd(){
        //THEN
        XCTAssertTrue(self.stringContext.isFinish(inCaseOf: "\""))
        XCTAssertFalse(self.stringContext.isFinish(inCaseOf: " "))
    }
    
   
    
    func testValueContextStart(){
        //WHEN
        guard let context = Context.init(rawValue: " ") else { return }
        //THEN
        XCTAssertTrue(self.arrayContext.canInclude(context: context))
    }
    
    func testValueContextEnd(){
        //THEN
        XCTAssertTrue(self.valueContext.isFinish(inCaseOf: ","))
        XCTAssertTrue(self.valueContext.isFinish(inCaseOf: "]"))
    }
    
}


