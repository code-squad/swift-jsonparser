//
//  JsonValueCounterTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 02/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class JsonValueCounterTests: XCTestCase {
    //Given
    let counter = JsonValueCounter()
    
    func testObjectCount() {
        //Given
        let object: JsonObject =  ["name" : "부엉이" , "age" : 27]
        
        //When
        let numOf = self.counter.count(target: object)
        
        //Then
        XCTAssertEqual(numOf["문자열"], 1)
        XCTAssertEqual(numOf["숫자"], 1)
    }
    
    func testListCount() {
        //Given
        let list: JsonList =  ["name", true, "부엉이" , "age" , 27]
        
        //When
        let numOf = self.counter.count(target: list)
        
        //Then
        XCTAssertEqual(numOf["문자열"], 3)
        XCTAssertEqual(numOf["숫자"], 1)
        XCTAssertEqual(numOf["부울"], 1)
    }

}
