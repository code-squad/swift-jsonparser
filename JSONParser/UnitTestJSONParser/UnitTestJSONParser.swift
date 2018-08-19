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
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }

    func testArray_Pass_객체데이터2개여러개(){
        let input = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }

    func testArray_Pass_숫자(){
        let input = "[ 10, 21, 4, 314, 99, 0, 72 ]"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }

    func testArray_Pass_문자숫자부울(){
        let input = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }

    func testArray_Fail_객체형식이상할때(){
        let input = "[ \"name\" : \"KIM JUNG\" ]"
        XCTAssertThrowsError(try GrammarChecker.isValidate(to: input)) { error in
            XCTAssertEqual(error as? JsonError, JsonError.unSupportedArrayPattern)
        }
    }
    
    func testObject_Pass_객체데이터1개(){
        let input = "{ \"level\" : 5 }"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }
    
    func testObject_Pass_객체데이터2개(){
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\" }"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }
    
    func testObject_Pass_객체데이터2개_StringWithInt(){
        let input = "{ \"name\" : \"KIM JUNG\", \"level\" : 5 }"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }

    func testObject_Pass_객체데이터3개(){
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5 }"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }
    
    func testObject_Pass_객체데이터4개(){
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }

    func testArray_Pass_배열데이터안에_대괄호짝이상해도_통과되는지(){
        let input = "[{\"name\":\"[oingbong[]\"}]"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }

    func testArray_Pass_배열데이터안에_중괄호짝이상해도_통과되는지(){
        let input = "[{\"name\":\"[oingbong{{}}}}}}}}\"}]"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }

    func testObject_Pass_객체데이터안에_대괄호짝이상해도_통과되는지(){
        let input = "{\"name\":\"[oingbong[]\"}"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }

    func testObject_Pass_객체데이터안에_중괄호짝이상해도_통과되는지(){
        let input = "{\"name\":\"[oingbong{}}{{}}\"}"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }
    
    func testArray_Pass_1(){
        let input = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false, {\"name\":\"dd\"}, [1234,\"name\",true] ]"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }
    
    func testArray_Pass_2(){
        let input = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false, {\"name\":\"dd\"} ]"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }
    
    func testArray_Pass_3(){
        let input = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false, [1234,\"name\",true] ]"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }
    
    func testArray_Pass_4(){
        let input = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false, {\"name\":\"dd\"}, [1234] ]"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }
    
    func testArray_Pass_5(){
        let input = "[ { \"name\" : \"master's course\", \"opened\" : true }, [ \"java\", \"javascript\", \"swift\" ] ]"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }
    
    func testObject_Pass_1(){
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }
    
    func testCheckPattern_Fail1(){
        let input = "[{{,}}]"
        XCTAssertThrowsError(try GrammarChecker.isValidate(to: input)) { error in
            XCTAssertEqual(error as? JsonError, JsonError.unSupportedArrayPattern)
        }
    }
    
    func testCheckPattern_Fail2(){
        let input = "{[[,]]}"
        XCTAssertThrowsError(try GrammarChecker.isValidate(to: input)) { error in
            XCTAssertEqual(error as? JsonError, JsonError.unSupportedObjectPattern)
        }
    }
    
    func testCheckPattern_Fail3(){
        let input = "{][[[]]}"
        XCTAssertThrowsError(try GrammarChecker.isValidate(to: input)) { error in
            XCTAssertEqual(error as? JsonError, JsonError.unSupportedObjectPattern)
        }
    }
    
    func testCheckPattern_Fail4(){
        let input = "[}{]"
        XCTAssertThrowsError(try GrammarChecker.isValidate(to: input)) { error in
            XCTAssertEqual(error as? JsonError, JsonError.unSupportedArrayPattern)
        }
    }
    
    func testCheckPattern_Fail5(){
        let input = "{[],[]}"
        XCTAssertThrowsError(try GrammarChecker.isValidate(to: input)) { error in
            XCTAssertEqual(error as? JsonError, JsonError.unSupportedObjectPattern)
        }
    }
    
    func testObject_Pass_객체안에배열(){
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }
    
    func testObject_Pass_객체안에객체(){
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, , {\"name\":\"oing\"} }"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }
    
    func testArray_Pass_배열안에배열(){
        let input = "[ { \"name\" : \"master's course\", \"opened\" : true }, [ \"java\", \"javascript\", \"swift\" ] ]"
        XCTAssertNoThrow(try GrammarChecker.isValidate(to: input))
    }
    
    func test_makeObject_Pass(){
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5 }"
        var object = [String:JsonType]()
        object.updateValue(JsonType.string("\"KIM JUNG\""), forKey: "\"name\"")
        object.updateValue(JsonType.string("\"JK\""), forKey: "\"alias\"")
        let intValue = JsonParse.makeInt(to: "5")
        object.updateValue(JsonType.int(intValue), forKey: "\"level\"")
        XCTAssertEqual(JsonParse.makeObject(to: input), object)
    }
    
    func test_makeArray_Pass(){
        let input = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        var array = [JsonType]()
        let intValue1 = JsonParse.makeInt(to: "10")
        let intValue2 = JsonParse.makeInt(to: "4")
        let intValue3 = JsonParse.makeInt(to: "99")
        let boolValue = JsonParse.makeBool(to: "false")
        array.append(JsonType.int(intValue1))
        array.append(JsonType.string("\"jk\""))
        array.append(JsonType.int(intValue2))
        array.append(JsonType.string("\"314\""))
        array.append(JsonType.int(intValue3))
        array.append(JsonType.string("\"crong\""))
        array.append(JsonType.bool(boolValue))
        XCTAssertEqual(JsonParse.makeArray(to: input), array)
    }
    
    func test_makeArray_Pass_배열안에객체배열중첩일때(){
        let input = "[ { \"name\" : \"master's course\", \"opened\" : true }, [ \"java\", \"javascript\", \"swift\" ] ]"
        var array = [JsonType]()
        let objectValue = JsonParse.makeObject(to: "{ \"name\" : \"master's course\", \"opened\" : true }")
        array.append(JsonType.object(objectValue))
        let arrayValue = JsonParse.makeArray(to: "[ \"java\", \"javascript\", \"swift\" ]")
        array.append(JsonType.array(arrayValue))
        XCTAssertEqual(JsonParse.makeArray(to: input), array)
    }
    
    func test_makeArray_Pass_배열안에배열중첩일때(){
        let input = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false, [ \"java\", \"javascript\", \"swift\" ] ]"
        var array = [JsonType]()
        let intValue1 = JsonParse.makeInt(to: "10")
        let intValue2 = JsonParse.makeInt(to: "4")
        let intValue3 = JsonParse.makeInt(to: "99")
        let boolValue = JsonParse.makeBool(to: "false")
        array.append(JsonType.int(intValue1))
        array.append(JsonType.string("\"jk\""))
        array.append(JsonType.int(intValue2))
        array.append(JsonType.string("\"314\""))
        array.append(JsonType.int(intValue3))
        array.append(JsonType.string("\"crong\""))
        array.append(JsonType.bool(boolValue))
        let arrayValue = JsonParse.makeArray(to: "[ \"java\", \"javascript\", \"swift\" ]")
        array.append(JsonType.array(arrayValue))
        XCTAssertEqual(JsonParse.makeArray(to: input), array)
    }
    
    func test_makeArray_Pass_배열안에객체중첩일때(){
        let input = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false, { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true } ]"
        var array = [JsonType]()
        let intValue1 = JsonParse.makeInt(to: "10")
        let intValue2 = JsonParse.makeInt(to: "4")
        let intValue3 = JsonParse.makeInt(to: "99")
        let boolValue = JsonParse.makeBool(to: "false")
        array.append(JsonType.int(intValue1))
        array.append(JsonType.string("\"jk\""))
        array.append(JsonType.int(intValue2))
        array.append(JsonType.string("\"314\""))
        array.append(JsonType.int(intValue3))
        array.append(JsonType.string("\"crong\""))
        array.append(JsonType.bool(boolValue))
        let objectValue = JsonParse.makeObject(to: "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }")
        array.append(JsonType.object(objectValue))
        XCTAssertEqual(JsonParse.makeArray(to: input), array)
    }
    
    func test_makeObject_Pass_객체안에배열중첩일때(){
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        var object = [String:JsonType]()
        object.updateValue(JsonType.string("\"KIM JUNG\""), forKey: "\"name\"")
        object.updateValue(JsonType.string("\"JK\""), forKey: "\"alias\"")
        let intValue = JsonParse.makeInt(to: "5")
        object.updateValue(JsonType.int(intValue), forKey: "\"level\"")
        let arrayValue = JsonParse.makeArray(to: "[\"hana\", \"hayul\", \"haun\"]")
        object.updateValue(JsonType.array(arrayValue), forKey: "\"children\"")
        XCTAssertEqual(JsonParse.makeObject(to: input), object)
    }
    
    func test_makeObject_Pass_객체안에객체중첩일때(){
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true } }"
        var object = [String:JsonType]()
        object.updateValue(JsonType.string("\"KIM JUNG\""), forKey: "\"name\"")
        object.updateValue(JsonType.string("\"JK\""), forKey: "\"alias\"")
        let intValue = JsonParse.makeInt(to: "5")
        object.updateValue(JsonType.int(intValue), forKey: "\"level\"")
        let objectValue = JsonParse.makeObject(to: "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }")
        object.updateValue(JsonType.object(objectValue), forKey: "\"children\"")
        XCTAssertEqual(JsonParse.makeObject(to: input), object)
    }
    
    func test_main_Array_Pass(){
        let input = "[ { \"name\" : \"master's course\", \"opened\" : true }, [ \"java\", \"javascript\", \"swift\" ] ]"
        let example = """
        [{
                \"name\": \"master's course\",
                \"opened\": true
            },
            [\"java\", \"javascript\", \"swift\"]
        ]
        """
        print(example)
        XCTAssertFalse(analyzeJson(to: input))
    }
//    [ 10, "jk", 4, "314", 99, "crong", false, [ 10, "jk", 4, "314", 99, "crong", false ] , { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true } ]
    func test_main_Array_Pass2(){
        let input = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false, [ 10, \"jk\", 4, \"314\", 99, \"crong\", false ] , { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true } ]"
        let example = """
        [10, "jk", 4, "314", 99, "crong", false, [10, "jk", 4, "314", 99, "crong", false], {
            "name": "KIM JUNG",
            "alias": "JK",
            "level": 5,
            "married": true
        }]
        """
        print(example)
        XCTAssertFalse(analyzeJson(to: input))
    }
    
    func test_main_Object_Pass(){
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        let example = """
        {
            \"name\": \"KIM JUNG\",
            \"alias\": \"JK\",
            \"level\": 5,
            "children": [\"hana\", \"hayul\", \"haun\"]
        }
        """
        print(example)
        XCTAssertFalse(analyzeJson(to: input))
    }
//    { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "children" : ["hana", "hayul", "haun"], "object" : { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "children" : ["hana", "hayul", "haun"] } }
    
    func test_main_Object_Pass2(){
        let input = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"], \"object\" : { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] } }"
        let example = """
        {
            "name": "KIM JUNG",
            "alias": "JK",
            "level": 5,
            "children": ["hana", "hayul", "haun"],
            "object": {
                "name": "KIM JUNG",
                "alias": "JK",
                "level": 5,
                "children": ["hana", "hayul", "haun"]
            }
        }
        """
        print(example)
        XCTAssertFalse(analyzeJson(to: input))
    }
    
    
    
    
    
    
    
    
    
}
