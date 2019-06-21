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
        
        let tokens = ["[","1","true","\"name\"","]"]
        var parser =  JSONParser(tokens: tokens)
        let expected: [JSONDataType] = [1,true,"name"]
        let result = ( try! parser.parse() ) as! [JSONDataType]
        for (index,_) in result.enumerated() {
            XCTAssertEqual(result[index].typeDescription,                      expected[index].typeDescription)
        }
    }
    
    func testParseObject() {
        let tokens = ["{","\"zieunv\"",":", "true", "\"mindy\"",":" ,"23", "\"부엉이\"",":", "27" ,"}"]
        var parser = JSONParser(tokens: tokens)
        let expected: [ String : JSONDataType] = ["zieunv" : true,"mindy":23, "부엉이": 27]
        let result = (try! parser.parse() ) as! [JSONDataType]
        for(index,_) in result.enumerated() {
            XCTAssertEqual(result[index].typeDescription, expected.typeDescription)
        }
    }
    

}
