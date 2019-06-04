//
//  GrammerCheckerUnitTest.swift
//  JSONParserUnitTest
//
//  Created by hw on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest
extension String {
    func jsonPatternCheck(for regex: String, in inputString: String) -> [JsonParsable] {
        do {
            if let regex = try? NSRegularExpression(pattern: regex, options: .caseInsensitive){
                let test = regex.matches(in: inputString, options: [], range: NSRange(location:0, length: inputString.count))
                let result : [JsonParsable] = test.map{ String(inputString[Range($0.range, in: inputString)!])}.filter{!$0.isEmpty}
                return result
            }
        }
        //if fails
        return []
    }
    
    func isJsonPattern(for regex: String, in inputString: String ) -> Bool {
        do {
            if let regex = try? NSRegularExpression(pattern: regex, options: .caseInsensitive){
                let test = regex.matches(in: inputString, options: [], range: NSRange(location:0, length: inputString.count))
                let foundJsonFormat : [JsonParsable] = test.map{ String(inputString[Range($0.range, in: inputString)!])}.filter{!$0.isEmpty}
                let result =  foundJsonFormat.count == 0 ? false : true
                return result 
            }
        }
        //if fails
        return false
    }
}
class GrammerCheckerUnitTest: XCTestCase {
    
    let testInputJsonObject = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true }, true, \"context\" ]"
    let testSimpleInput = "[ 10 , \"jk\", 4, \"314\", 99, \"cro ng\", false, [ \"json\", [ false, 10 ], \"Array\" ], \"[ SquareBr, acke, tTest ]\", {\"abc\" : 10, \"bool\" : true}, \"{, {. [, [, curly , , ] ] ] ] \" ]"
    let testJsonObject = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true, \"{ : }\" : \":\", \"curly bracket\":{ \"key\" : \"value\", \"size\" : 10, \"content\" : [ 10, 20, 30, 40 ] } }"
    
    let test = "[ \"json\", [ false, 10 ], \"Array\" ]"
    let jsonObject = "[ \"name\" , \"KIM JUNG\" ]"
    
    /** Value 규칙
     * 1) true|false값은 연속되거나 부분문자로 포함되어서는 안된다. \"문자열\"의 문자열의 부분문자열로는 상관이 없다.
     * 2) value로 들어오는 문자열은 빈 문자열이어도 무방하다.
     */

    /** JsonObject 규칙
     * 1) Value 규칙을 따른다.
     * 2) key로는 무조건 길이 1이상의 문자열이 와야한다.
     * 3) 숫자는 정수값을 전제하므로 음의 정수도 포함한다.
     * 4) 정규식 패턴 검사의 결과는 단일 포맷으로 떨어진다.
     * 5) (입력문자열의 형식검증이므로) 올바르게 입력된 key 문자열의 중복을 검사하지는 않는다.
     */
    let jsonObjectPattern = "^\\{\\s*((\\\"[^\\\"]+\\\")\\s*:\\s*((\\\"[^\\\"]*\\\")|([-]?[\\d]+)|(true|false)))((\\s*,\\s*)((\\\"[^\\\"]+\\\")\\s*:\\s*((\\\"[^\\\"]*\\\")|([-]?[\\d]+)|(true|false))))*\\s*\\}$"
    /** JsonArray 규칙
     * 1) Value 규칙을 따른다.
     * 2) JsonObject 를 원소로 포함한다. (JsonObject를 내부 Value규칙에 포함한다.)
     * 3) Number(Int), Bool, String, JsonObject 값만 갖는다.
     * 4) 정규식 패턴 검사의 결과는 단일 포맷으로 떨어진다.
     */
    let jsonArrayWithPrimitiveValuePattern = "^\\[\\s*(([-]*[\\d]+)|(\\s*(\\\"[^\"]*\\\")\\s*)|(true|false))(((\\s*,\\s*[-]*[\\d]+)|(\\s*,\\s*(\\\"[^\"]*\\\")))|((\\s*,\\s*)(true|false)))*\\s*\\]$"
    
    let jsonArrayWithJsonObjectPattern = "^\\[\\s*(([-]*[\\d]+)|(\\s*(\\\"[^\"]+\\\")\\s*)|(true|false)|(\\{\\s*((\\\"[^\"]+\\\")\\s*:\\s*((\\\"[^\"]*\\\")|([-]?[\\d]+)|(true|false)))((\\s*,\\s*)((\\\"[^\\\"]+\\\")\\s*:\\s*((\\\"[^\\\"]*\\\")|([-]?[\\d]+)|(true|false))))*\\s*\\}))(((\\s*,\\s*[-]*[\\d]+)|(\\s*,\\s*(\\\"[^\\\"]*\\\")))|((\\s*,\\s*)(true|false))|(\\s*,\\s*(\\{\\s*((\\\"[^\"]+\\\")\\s*:\\s*((\\\"[^\"]*\\\")|([-]?[\\d]+)|(true|false)))((\\s*,\\s*)((\\\"[^\\\"]+\\\")\\s*:\\s*((\\\"[^\\\"]*\\\")|([-]?[\\d]+)|(true|false))))*\\s*\\})))*\\s*\\]$"

    func testQuatatedStringAndNonQuatatedString(){
        let textWithoutQuatation = "abdcasf"
        let textWithQuatation = "\"abdcasf\""
        let quatatedStringPattern = "\\\"[^\"]*\\\""
        var result = textWithoutQuatation.jsonPatternCheck(for: quatatedStringPattern, in: textWithoutQuatation)
        XCTAssert(result.count == 0, "\(textWithoutQuatation) is quatated String")
        result = textWithQuatation.jsonPatternCheck(for: quatatedStringPattern, in: textWithQuatation)
        XCTAssert(result.count == 1, "\(textWithQuatation) is not quatated String")
    }
    
    func testQuatationStringGrammar(){
        let testInput = "\" test input is here\" \"test input 2\" string "
        let stringPattern = "\\\"[^\"]*\\\""
        let result = testInput.jsonPatternCheck(for: stringPattern, in: testInput)
        print("testQuatationStringGrammar result > :\n \(result)")
        XCTAssert(result.count == 2, "\(result). test input is not quatated string ")
    }
    
    func testJsonObjectGrammar(){
        var testObject = "{ \"key\" : \"value\"  ,  \" number \" : -10 ,  \"boolean\" : true , \"noname\": 100 , \"key\":\"\"}"
        var result = testObject.jsonPatternCheck(for: jsonObjectPattern, in: testObject)
        print("testJsonObjectGrammar result > :\n \(result)")
        XCTAssert(result.count == 1, "\(testObject) is not jsonObject Format")
        
        testObject = "[ \"name\" : \"KIM JUNG\" ]"
        result = testObject.jsonPatternCheck(for: jsonObjectPattern, in: testObject)
        print("testJsonObjectGrammar : \(testObject) result > :\n \(result)")
        XCTAssert(result.count == 0, "\(testObject) is jsonObject Format")
    }
    
    func testJsonObjectHasNoJsonArrayGrammar(){
        var testObject =  "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"child1\" : \"hana\", \"child2\": \"hayul\", \"child3\" : \"haun\" }"
        var result = testObject.jsonPatternCheck(for: jsonObjectPattern, in: testObject)
        XCTAssert(result.count == 1, "\(testObject) is not jsonObject Format")
        
        testObject = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        result = testObject.jsonPatternCheck(for: jsonObjectPattern, in: testObject)
        XCTAssert(result.count == 0, "\(testObject) is jsonObject Format")
    
    }
    func testJsonObjectKeyGrammar(){
        let testObjectWithValidKey = "{ \"key\" : \"value\"  ,  \" number \" : -10 ,  \"boolean\" : true , \"valid\": 100 , \"key\":\"\"}"
        let testObjectWithInvalidKey = "{ \"key\" : \"value\"  ,  \" number \" : -10 ,  \"boolean\" : true , \"\": 100 , \"key\":\"\"}"

        let resultForValidFormat = testObjectWithValidKey.jsonPatternCheck(for: jsonObjectPattern, in: testObjectWithValidKey)
        let resultForInvalidFormat = testObjectWithInvalidKey.jsonPatternCheck(for: jsonObjectPattern, in: testObjectWithInvalidKey)
        print("testJsonObjectKeyGrammar-testObjectWithValidKey- result > :\n \(resultForValidFormat)")
        print("testJsonObjectKeyGrammar-testObjectWithInvalidKey- result > :\n \(resultForInvalidFormat)")

        XCTAssert(resultForValidFormat.count == 1, "\(testObjectWithValidKey) has invalid key ")
        XCTAssert(resultForInvalidFormat.count == 0, "\(testObjectWithInvalidKey) has valid key ")
    }
    
    func testJsonObjectNoKeyOrValueGrammar(){
        var testObject = "{ \"key\" : \"value\"  ,  \" number \" : -10 ,  : true , \"valid\": 100 , \"key\":\"\"}"
        var result = testObject.jsonPatternCheck(for: jsonObjectPattern, in: testObject)
        XCTAssert(result.count == 0, "\(testObject) has keys for each value ")
       
        testObject = "{ \"key\" : \"value\"  ,  \" number \" : -10 ,  :  , \"valid\": 100 , \"key\":\"\"}"
        result = testObject.jsonPatternCheck(for: jsonObjectPattern, in: testObject)
        XCTAssert(result.count == 0, "\(testObject) has no key and value besides semicolon")
        
        testObject = "{ \"key\" : \"value\"  ,  \" number \" : -10 ,  , \"valid\": 100 , \"key\":\"\"}"
        result = testObject.jsonPatternCheck(for: jsonObjectPattern, in: testObject)
        XCTAssert(result.count == 0, "\(testObject) has right comma in place ")
        
        testObject = "{ \"key\" : \"value\"  ,  \" number \" : -10 ,  \"valid\":  , \"key\":\"\"}"
        result = testObject.jsonPatternCheck(for: jsonObjectPattern, in: testObject)
        XCTAssert(result.count == 0, "\(testObject) has no value for each key ")

        testObject = "{ \"key\" : \"value\"  ,  \" number \" : -10 ,  \"valid\" true , \"key\":\"\"}"
        result = testObject.jsonPatternCheck(for: jsonObjectPattern, in: testObject)
        XCTAssert(result.count == 0, "\(testObject) has right seimicolon in place ")
    }
    
    
    func testJsonArrayBooleanGrammar(){
        var testOfBooleanValue = "[ false, falsefalse, false afalse, false1234, truetrue, true true, 12345adfds, trueadf1234, asdf12545 ]"
        var resultForValidArrayFormat = testOfBooleanValue.jsonPatternCheck(for: jsonArrayWithPrimitiveValuePattern, in: testOfBooleanValue)
        XCTAssert(resultForValidArrayFormat.count == 0, "\(testOfBooleanValue) has valid boolean format ")
        
        testOfBooleanValue = "[ false, true, false, true, true]"
        resultForValidArrayFormat = testOfBooleanValue.jsonPatternCheck(for: jsonArrayWithPrimitiveValuePattern, in: testOfBooleanValue)
        XCTAssert(resultForValidArrayFormat.count == 1, "\(testOfBooleanValue) has in valid boolean format ")

    }
    
    func testJsonArrayNumericGrammar(){
         var testOfNumericValue = "[    10, 129435 , 19435 , 1234,  -10 , -20, -30   ]"
         var resultForValidArrayFormat = testOfNumericValue.jsonPatternCheck(for: jsonArrayWithPrimitiveValuePattern, in: testOfNumericValue)
         XCTAssert(resultForValidArrayFormat.count == 1, "\(testOfNumericValue) has invalid number format ")
         XCTAssertNotNil(resultForValidArrayFormat[0], "\(resultForValidArrayFormat) has no value")
        
         testOfNumericValue = "[ 10, 129435 , 19435 , 1234,  -10 , -20, -30, noStr657ing ]"
         resultForValidArrayFormat = testOfNumericValue.jsonPatternCheck(for: jsonArrayWithPrimitiveValuePattern, in: testOfNumericValue)
         XCTAssert(resultForValidArrayFormat.count == 0, "\(testOfNumericValue) has valid number format ")
    }
    
    func testJsonArrayQuatatedStringGrammar(){
        var testOfNonQuatatedString = "[ \"fal998 124, afs,, , [ ] { } {[ }] 12:34true1234 s/e\" , 129435 , \"string\", true, \"[ ] \"  ]"
        var result = testOfNonQuatatedString.jsonPatternCheck(for: jsonArrayWithPrimitiveValuePattern, in: testOfNonQuatatedString)
        XCTAssert(result.count == 1, "\(testOfNonQuatatedString) is non valid JsonArray format")
        
        testOfNonQuatatedString = "[ \"fal998 124, afs,, , \"[ ] { } {[ }] 12:34true1234 s/e\" , 129435 , \"string\", true, \"[ ] \"  ]"
        result = testOfNonQuatatedString.jsonPatternCheck(for: jsonArrayWithPrimitiveValuePattern, in: testOfNonQuatatedString)
        XCTAssert(result.count == 0, "\(testOfNonQuatatedString) is valid JsonArray format")
        
        testOfNonQuatatedString = "[ \"fal998 124, afs,, , [ ] { } {[ }] 12:34true1234 s/e\" , 129435 , \"string\", true,  \"[ ] \"  \"]"
        result = testOfNonQuatatedString.jsonPatternCheck(for: jsonArrayWithPrimitiveValuePattern, in: testOfNonQuatatedString)
        XCTAssert(result.count == 0, "\(testOfNonQuatatedString) is valid JsonArray format")
    }
    
    func testJsonArrayNonQuatatedStringGrammar(){
        let testOfNonQuatatedString = "[ \"129435\" ,string, true ]"
        let result = testOfNonQuatatedString.jsonPatternCheck(for: jsonArrayWithPrimitiveValuePattern, in: testOfNonQuatatedString)
        XCTAssert(result.count == 0, "\(testOfNonQuatatedString) is valid JsonArray format")
    }
    
    func testJsonArrayWithJsonObjectGrammar(){
        var testInput = "[ { \"object key\": 10 }, 10, 20, true, false, \"string value\", { \"key\" : true , \"  \": false, \"valid key \":true}]"
        var result = testInput.jsonPatternCheck(for: jsonArrayWithJsonObjectPattern, in: testInput)
        print("testJsonArrayWithJsonObjectGrammar result > :\n \(result)")
        XCTAssert(result.count == 1, "\(testInput) is invalid json array format ")
        
        testInput = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true },"
        testInput += "{ \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
        result = testInput.jsonPatternCheck(for: jsonArrayWithJsonObjectPattern, in: testInput)
        print("testJsonArrayWithJsonObjectGrammar result > :\n \(result)")
        XCTAssert(result.count == 1, "\(testInput) is invalid json array format ")
    }
    
    func testJsonArrayWithInvalidJsonObjectGrammar1(){
        let testInput = "[ { \"object key\": 10 , 10, 20, true, false, \"string value\", { \"key\" : true , \"  \": false, \"valid key \":true}]"
        let result = testInput.jsonPatternCheck(for: jsonArrayWithJsonObjectPattern, in: testInput)
        print("\(testInput) result > :\n \(result)")
        XCTAssert(result.count == 0, "\(testInput) is valid json array format ")
    }
    
    func testJsonArrayWithInvalidJsonObjectGrammar2(){
        var testInput = "[ [ \"object key\": 10 ] , 10, 20, true, false, \"string value\", { \"key\" : true , \"  \": false, \"valid key \":true}]"
        var result = testInput.jsonPatternCheck(for: jsonArrayWithJsonObjectPattern, in: testInput)
        XCTAssert(result.count == 0, "\(testInput) is valid json array format ")
        
        testInput = "[ { \"object key\": 10 } , 10, 20, true, false, \"string value\", { \"key\" : true , \"\": false, \"valid key \":true}]"
        result = testInput.jsonPatternCheck(for: jsonArrayWithJsonObjectPattern, in: testInput)
        XCTAssert(result.count == 0, "\(testInput) has valid JsonObject keys in a given JsonArray format ")
        
        //key가 없는 경우
        testInput = "[ { \"object key\": 10 } , {10, 20}, true, false, \"string value\", { \"key\" : true , \"\": false, \"valid key \":true}]"
        result = testInput.jsonPatternCheck(for: jsonArrayWithJsonObjectPattern, in: testInput)
        XCTAssert(result.count == 0, "\(testInput) has valid JsonObject format in a given JsonArray format ")

    }
    
    
    func testCheckJsonGrammar1(){
        let invalidJsonArray = "[ \"name\" : \"KIM JUNG\" ]"
        var result = false
        result = invalidJsonArray.isJsonPattern(for: jsonObjectPattern, in: invalidJsonArray )
        result = result ? result : invalidJsonArray.isJsonPattern(for: jsonArrayWithJsonObjectPattern, in: invalidJsonArray)
        XCTAssert(!result  , "\(invalidJsonArray) is not Json format on the condition that STEP 7-3 gives" )
        
    }
    func testCheckJsonGrammar2(){
        let invalidJsonObject = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"children\" : [\"hana\", \"hayul\", \"haun\"] }"
        var result = false
        result = invalidJsonObject.isJsonPattern(for: jsonObjectPattern, in: invalidJsonObject)
        result = result ? result : invalidJsonObject.isJsonPattern(for: jsonArrayWithJsonObjectPattern, in: invalidJsonObject)
        XCTAssert(!result , "\(invalidJsonObject) is not Json format on the condition that STEP 7-3 gives" )

    }
    func testCheckJsonGrammar3(){
        let validJsonObject = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        var result = false
        result = validJsonObject.isJsonPattern(for: jsonObjectPattern, in: validJsonObject)
        result = result ? result : validJsonObject.isJsonPattern(for: jsonArrayWithJsonObjectPattern, in: validJsonObject)
        result ? print("\(validJsonObject) is Json format ") : print("\(validJsonObject) is not Json format on the condition that STEP 7-3 gives")
        XCTAssert(result, "\(validJsonObject) is not Json format on the condition that STEP 7-3 gives" )

    }
    func testCheckJsonGrammar4() {
        let validJsonArray = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true } ]"
        var result = false
        result = validJsonArray.isJsonPattern(for: jsonObjectPattern, in: validJsonArray)
        result = result ? result : validJsonArray.isJsonPattern(for: jsonArrayWithJsonObjectPattern, in: validJsonArray)
        result ? print("\(validJsonArray) is Json format ") : print("\(validJsonArray) is not Json format on the condition that STEP 7-3 gives")
        XCTAssert(result, "\(validJsonArray) is not Json format on the condition that STEP 7-3 gives" )

    }

}
