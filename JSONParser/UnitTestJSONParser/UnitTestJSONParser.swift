//
//  UnitTestJSONParser.swift
//  UnitTestJSONParser
//
//  Created by oingbong on 2018. 8. 9..
//  Copyright © 2018년 JK. All rights reserved.
//

import XCTest

class UnitTestJSONParser: XCTestCase {
    
    func testCheckArray_Pass1(){
        var input = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
        let isTrue = input.unsupportedArrayTypes()
        XCTAssertTrue(isTrue)
    }
    
    func testCheckArray_Pass2(){
        var input = "[ 10, 21, 4, 314, 99, 0, 72 ]"
        let isTrue = input.unsupportedArrayTypes()
        XCTAssertTrue(isTrue)
    }
    
    func testCheckArray_Pass3(){
        var input = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let isTrue = input.unsupportedArrayTypes()
        XCTAssertTrue(isTrue)
    }
    
    func testCheckArray_Pass4(){
        var input = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true },{ \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
        let isTrue = input.unsupportedArrayTypes()
        XCTAssertTrue(isTrue)
    }
    
    func testCheckArray_Fail1(){
        var input = "[ \"name\" : \"KIM JUNG\" ]"
        let isFail = input.unsupportedArrayTypes()
        print(isFail)
        XCTAssertFalse(isFail)
    }
    
    func testCheckObject_Pass1(){
        var input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let isTrue = input.unsupportedArrayTypes()
        XCTAssertTrue(isTrue)
    }
    
    func testCheckObject_Pass2(){
        var input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let isTrue = input.unsupportedArrayTypes()
        XCTAssertTrue(isTrue)
    }

    
    func testCheckPattern_Fail1(){
        let input = "[{{,}}]"
        let isFalse = GrammarChecker.checkException(to: input)
        XCTAssertFalse(isFalse)
    }
    
    func testCheckPattern_Fail2(){
        let input = "{[[,]]}"
        let isFalse = GrammarChecker.checkException(to: input)
        XCTAssertFalse(isFalse)
    }
    
    func testCheckPattern_Fail3(){
        let input = "{][[[]]}"
        let isFalse = GrammarChecker.checkException(to: input)
        XCTAssertFalse(isFalse)
    }
    
    func testCheckPattern_Fail4(){
        let input = "[}{]"
        let isFalse = GrammarChecker.checkException(to: input)
        XCTAssertFalse(isFalse)
    }
    
    func testCheckPattern_Fail5(){
        let input = "{[],[]}"
        let isFalse = GrammarChecker.checkException(to: input)
        XCTAssertFalse(isFalse)
    }

}
