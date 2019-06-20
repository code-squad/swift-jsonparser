//
//  JSONParserTests.swift
//  JSONParserTests
//
//  Created by JieunKim on 17/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class JSONParserTests: XCTestCase {

    func testParseArray() {
        let tokens = ["1","true","\"name\""]
        let result =  JSONParser.parseArray(tokens: tokens)!
        let expected: [JSONDataType] = [1,true,"name"]
        
        for (index,_) in result.enumerated() {
            XCTAssertEqual(result[index].typeDescription,                      expected[index].typeDescription)
        }
    }

}
