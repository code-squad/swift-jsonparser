//
//  GrammerCheckerTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 17/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class GrammerCheckerTests: XCTestCase {
    
    // Given
    let checker = GrammerChecker()
    
    let listFormat = "[ \"부엉이\" , \"27\" , 25 , true ]"
    let listFormat2 = "[1, true ]"
    let listFormat3 = "[1,2,3,4,\"hello\"]"
    let objectFormat = "{ \"name\" : \"부엉이\"  , \"age\": 27 , \"married\" : false }"
    let outOfFormObject = "{ name : \"부엉이\" , \"age\" : 27 , \"married\" : false }"
    let outOfFormJson = "[ \"name\" : \"KIM JUNG\" ]"
    
    func testCheckOutOfForm() {
        //Then
        XCTAssertFalse(GrammerChecker.check(format: self.outOfFormJson))
    }
    
    func testCheckListFormat() {
        //Then
        XCTAssertTrue(GrammerChecker.check(format: self.listFormat))
        XCTAssertTrue(GrammerChecker.check(format: self.listFormat2))
        XCTAssertTrue(GrammerChecker.check(format: self.listFormat3))
    }
    
    
    func testCheckObjectFormat() {
        //Then
        XCTAssertTrue(GrammerChecker.check(format: self.objectFormat))
    }
    
    func testCheckObjectListFormat() {
        //Given
        let objectListFormat = "[\(objectFormat), \(objectFormat)]"
        
        //Then
        XCTAssertTrue(GrammerChecker.check(format: objectListFormat))
    }
    
    func testCheckNestedListFormat() {
        //Given
        let nestedListFormat = "[\(listFormat), \(listFormat)]"
        
        //Then
        XCTAssertFalse(GrammerChecker.check(format: nestedListFormat))
    }
    
    func testCheckHasObjectListFormat() {
        //Given
        let hasListObjectFormat = "{ \"list\" : \(listFormat)}"
        
        //Then
        XCTAssertTrue(GrammerChecker.check(format:hasListObjectFormat))
    }
    
    func testCheckHasObjectObjectFormat() {
        //Given
        let hasObjectObjectFormat = "{ \"list\" : \(self.objectFormat)}"
        
        //Then
        XCTAssertTrue(GrammerChecker.check(format:hasObjectObjectFormat))
    }
}
