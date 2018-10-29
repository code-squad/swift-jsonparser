//
//  UnitTestJSONDataForm.swift
//  JSONParserUnitTest
//
//  Created by 윤지영 on 27/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import XCTest

class UnitTestJSONDataForm: XCTestCase {

    func testJSONObjectCountTypeRight() {
        let jsonObject: [String: JSONData] = ["name" : "JIYEONG YUN", "alias" : "Jamie", "level" : 2, "smart" : true]
        XCTAssertEqual(jsonObject.countType(), ["문자열": 2, "숫자": 1, "부울": 1])
    }

    func testJSONArrayCountTypeRight() {
        let jsonArray: [JSONData] = ["JIYEONG YUN", "Jamie", 2, true, ["name" : "JIYEONG YUN", "alias" : "Jamie", "level" : 2, "smart" : true]]
        XCTAssertEqual(jsonArray.countType(), ["문자열": 2, "숫자": 1, "부울": 1, "객체": 1])
    }

}
