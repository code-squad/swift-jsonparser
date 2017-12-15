//
//  TestJsonParser.swift
//  TestJsonParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 15..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest

class TestJsonParser: XCTestCase {
    
    func testErrorOfInvalidInput () {
        let invalidInput = "123,false,\"Jeonghoon\"]"
        XCTAssertThrowsError(try SyntaxChecker.makeValidString(values: invalidInput)) { (error) -> Void in
            XCTAssertEqual(error as? SyntaxChecker.ErrorMessage , SyntaxChecker.ErrorMessage.ofNoSquareBracket)
        }
    }
    
    func testIsSuccessMakingCountingDataInstance () {
        let uncheckedValues = "[57,\"JeongHoon\",41,\"Korea\",120,\"make\",true,true,\"Choi\",2017]"
        let checkedValues = try! SyntaxChecker.makeValidString(values: uncheckedValues)
        let countedType: CountingData = Analyzer.makeCountedTypeInstance(checkedValues)
        XCTAssertNotNil(countedType)
    }
    
    func testIsSuccessMakingCountedTypeInstance () {
        let uncheckedValues = "[120,\"minimum\",12,\"Jazz\",2015,true]"
        let checkedValues = try! SyntaxChecker.makeValidString(values: uncheckedValues)
        let numberValue: [Int] = [120,12,2015]
        let boolValue: [Bool] = [true]
        let stringValue: [String] = ["\"minimum\"","\"Jazz\""]
        let countedType: CountingData = Analyzer.makeCountedTypeInstance(checkedValues)
        XCTAssertEqual(countedType.countOfNumericValue, numberValue)
        XCTAssertEqual(countedType.countOfBooleanValue, boolValue)
        XCTAssertEqual(countedType.countOfStringValue, stringValue)
        XCTAssertEqual(countedType.countOfTotalValue, 6)
    }
    
}
