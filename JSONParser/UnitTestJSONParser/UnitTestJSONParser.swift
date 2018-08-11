//
//  UnitTestJSONParser.swift
//  UnitTestJSONParser
//
//  Created by oingbong on 2018. 8. 9..
//  Copyright © 2018년 JK. All rights reserved.
//

import XCTest

class UnitTestJSONParser: XCTestCase {
    
    func testArray_Pass_객체데이터2개한개(){
        let input = "[{\"name\":\"oing\"},{\"name\":\"oing2\"}]"
        let isTrue = GrammarChecker.checkException(to: input)
        XCTAssertTrue(isTrue)
    }
    
    func testArray_Pass_객체데이터2개여러개(){
        let input = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
        let isTrue = GrammarChecker.checkException(to: input)
        XCTAssertTrue(isTrue)
    }
    
    func testArray_Pass_숫자(){
        let input = "[ 10, 21, 4, 314, 99, 0, 72 ]"
        let isTrue = GrammarChecker.checkException(to: input)
        XCTAssertTrue(isTrue)
    }
    
    func testArray_Pass_문자숫자부울(){
        let input = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let isTrue = GrammarChecker.checkException(to: input)
        XCTAssertTrue(isTrue)
    }
    
    func testArray_Fail_객체형식이상할때(){
        let input = "[ \"name\" : \"KIM JUNG\" ]"
        let isFail = GrammarChecker.checkException(to: input)
        print(isFail)
        XCTAssertFalse(isFail)
    }
    
    func testObject_Pass_객체데이터3개(){
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let isTrue = GrammarChecker.checkException(to: input)
        XCTAssertTrue(isTrue)
    }
    
    func testArray_Pass_배열데이터안에_대괄호짝이상해도_통과되는지(){
        let input = "[{\"name\":\"[oingbong[]\"}]"
        let isTrue = GrammarChecker.checkException(to: input)
        XCTAssertTrue(isTrue)
    }
    
    func testArray_Pass_배열데이터안에_중괄호짝이상해도_통과되는지(){
        let input = "[{\"name\":\"[oingbong{{}}}}}}}}\"}]"
        let isTrue = GrammarChecker.checkException(to: input)
        XCTAssertTrue(isTrue)
    }
    
    func testObject_Pass_객체데이터안에_대괄호짝이상해도_통과되는지(){
        let input = "{\"name\":\"[oingbong[]\"}"
        let isTrue = GrammarChecker.checkException(to: input)
        XCTAssertTrue(isTrue)
    }
    
    func testObject_Pass_객체데이터안에_중괄호짝이상해도_통과되는지(){
        let input = "{\"name\":\"[oingbong{}}{{}}\"}"
        let isTrue = GrammarChecker.checkException(to: input)
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
