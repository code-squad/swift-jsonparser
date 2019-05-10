//
//  JSONParserTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 11/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class ConverterTest: XCTestCase {
    
    func testConvertComposedOfIntegerData() {
        let input = "[ 10, 21, 4, 314, 99, 0, 72 ]"
        let array = try! Converter.stringToArray(string: input)
        XCTAssertEqual(array,["10","21","4","314","99","0","72"],"정수형 배열로의 변환에 성공합니다.")
    }
    
    func testConvertComposedOfMixedData() {
        let input =  "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let array = try! Converter.stringToArray(string: input)
        XCTAssertEqual(array,[ "10", "\"jk\""
            , "4", "\"314\"", "99", "\"crong\"", "false" ],"혼합된 데이터타입의 배열로의 변환에 성공합니다.")
    }
  
    
}
