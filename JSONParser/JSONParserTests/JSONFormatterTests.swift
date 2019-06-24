//
//  JSONFormatterTests.swift
//  JSONParserTests
//
//  Created by 이동영 on 24/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

class JSONFormatterTests: XCTestCase {

    let jsonList: JsonValue = [["name" : "master's course"],[ "java", "javascript", "swift" ]]
   
    func testJsonArray() {
        let result = JSONFormatter.stringfy(value: jsonList)
        let expected = """
        [ {\n\t\"name\" : \"master's course\"\n\t}, [ \"java\", \"javascript\", \"swift\" ] \n]
        """
        XCTAssertEqual(result, expected)
    }
    
    
}
