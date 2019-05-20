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
    let containerContext = Context.Container
    let elementContext = Context.Element
    let stringContext = Context.String
    
    func testContainerContextEnd(){
        //THEN
        XCTAssertTrue(self.containerContext.isEnd("]"))
    }
    
    func testStringContextEnd(){
        XCTAssertTrue(self.stringContext.isEnd("\""))
    }
    
    func testElementContextEnd(){
        XCTAssertTrue(self.elementContext.isEnd(","))
        XCTAssertTrue(self.elementContext.isEnd("]"))
    }
}


