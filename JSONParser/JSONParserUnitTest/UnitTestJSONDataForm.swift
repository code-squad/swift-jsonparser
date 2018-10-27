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
        let dic: [String: JSONValue] = ["name" : JSONValue.string("JIYEONG YUN"), "alias" : JSONValue.string("Jamie"), "level" : JSONValue.int(2), "smart" : JSONValue.bool(true)]
        let jsonObject = JSONObject.init(dic)
        XCTAssertEqual(jsonObject.countType(), ["문자열": 2, "숫자": 1, "부울": 1])
    }

    func testJSONArrayCountTypeRight() {
        let array = [JSONValue.string("JIYEONG YUN"), JSONValue.string("Jamie"), JSONValue.int(2), JSONValue.bool(true), JSONValue.object(JSONObject.init(["name" : JSONValue.string("JIYEONG YUN"), "alias" : JSONValue.string("Jamie"), "level" : JSONValue.int(2), "smart" : JSONValue.bool(true)]))]
        let jsonArray = JSONArray.init(array)
        XCTAssertEqual(jsonArray.countType(), ["문자열": 2, "숫자": 1, "부울": 1, "객체": 1])
    }

}
