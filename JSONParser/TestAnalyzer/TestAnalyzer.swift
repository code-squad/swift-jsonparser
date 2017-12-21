//
//  TestAnalyzer.swift
//  TestAnalyzer
//
//  Created by Choi Jeong Hoon on 2017. 12. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest

class TestAnalyzer: XCTestCase {
    
    // Mark : 타입카운팅 배열 요소 갯수 정상 여부 테스트
    func testIsSuccessMakingCountedTypeInstance () {
        let uncheckedValues = """
    [120, "minimum", 12,"Jazz" ,2015, true]
    """
        let checkedValues = try! GrammerChecker.makeValidString(values: uncheckedValues)
        let countedType: CountingData = Analyzer.makeCountedTypeInstance(checkedValues)
        XCTAssertEqual(countedType.ofBooleanValue, 1)
        XCTAssertEqual(countedType.ofNumericValue, 3)
        XCTAssertEqual(countedType.ofStringValue, 2)
        XCTAssertEqual(countedType.total, 6)
    }
}
