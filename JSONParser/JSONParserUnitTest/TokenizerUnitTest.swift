//
//  TokenizerUnitTest.swift
//  JSONParserUnitTest
//
//  Created by hw on 20/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import XCTest

//{ "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true }
//[ { "name" : "KIM JUNG", "alias" : "JK", "level" : 5, "married" : true }, false, 1, { "name" : "YOON JISU", "alias" : "crong", "level" : 4, "married" : true }, true, "context", "314", 314 ]
//[ 10, "jk", 4, "314", 99, "crong", false ]


class TokenizerUnitTest: XCTestCase {

    /// 5/20 unitTest
    func testSimpleJsonArrayTokenize() throws {
        let testSimpleInput = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let result = try splitFirstLevelToken(testSimpleInput)
        XCTAssert(result is JsonArray , "json array 문자열 분석 실패 ")
    }

    func testNestedJsonArrayTokenized() throws {
        let testInputJsonObject = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true }, true, \"context\" ]"
        let result = try splitFirstLevelToken(testInputJsonObject)
        print("test JsonArray result : > \(result.toString())")
        XCTAssert(result is JsonArray , "json array 문자열 분석 실패 ")

    }
    
    func testJsonObjectTokenize() throws {
        let testJsonObject = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }"
        let result = try splitFirstLevelToken(testJsonObject)
        print("test JsonObject result : > \(result.toString())")
        XCTAssert(result is JsonObject , "json object 문자열 분석 실패 ")

    }
    
    func splitFirstLevelToken(_ input : String) throws -> JsonParsable {
        var result : JsonParsable
        let type = checkInputType(input)
        switch type {
        case .jsonObject:
            result = try handleStringAsJsonObject(input)
            break
        case .jsonArray:
            let jsonArray = testHandleStringAsJsonArray(input)
            result = try testConvertJsonArrayElementDataType(tokenList: jsonArray)
            break
        default :
            throw ErrorCode.invalidJsonFormat
        }
        return result
    }
    
    private func handleStringAsJsonObject(_ input: String) throws -> JsonParsable {
        let trimmedInput = input[1..<input.count-1]
        let keyValueList = trimmedInput.components(separatedBy: ",")
        var keys: [String] = [String]()
        var values: [JsonValue] = [JsonValue]()
        for eachKeyValue in keyValueList{
            let keyValuePair: [String] = eachKeyValue.components(separatedBy: ":").map { $0.trimmingCharacters(in: .whitespacesAndNewlines)}
            let valueDataType = try convertJsonObjectStringValueToElementDataType(keyValuePair[1])
            keys.append(keyValuePair[0])
            values.append(valueDataType)
        }
        let jsonObject: JsonObject = JsonObject.init(keys: keys, values: values)
        return jsonObject
    }
    
    //subroutine of jsonObject
    private func convertJsonObjectStringValueToElementDataType(_ tokenValue : String ) throws -> JsonValue {
        let lexicalType = try confirmTokenDataType(tokenValue)
        let result : JsonValue = createJsonValueFromJsonObject(type: lexicalType, token: tokenValue)
        return result
    }
    
    private func createJsonValueFromJsonObject (type: LexicalType, token : String ) -> JsonValue {
        var result : JsonValue = JsonValue.init(token)
        switch type {
        case .bool :
            if let boolValue = Bool(token) {
                result = JsonValue.init(boolValue)
            }
        case .intNumber:
            if let intValue = Int(token) {
                result = JsonValue.init(intValue)
            }
        default :
            break
        }
        return result
    }
    
    private func confirmTokenDataType (_ token : String ) throws -> LexicalType {
        let testStringResult = isString(token)
        let testNumberResult = isNumeric(token)
        let testBooleanResult = isBoolean(token)
        let testJsonObjectResult = isJsonObject(token)
        let testJsonArrayResult = isJsonArray(token)
        let result = try decideElementLexicalType(string: testStringResult, number: testNumberResult, bool: testBooleanResult, jsonObject: testJsonObjectResult, jsonArray: testJsonArrayResult)
        return result
    }
    
    //subroutine of jsonArray
    func testConvertJsonArrayElementDataType (tokenList : [String]) throws -> JsonParsable{
        var result = JsonArray()
        for token in tokenList {
            let lexicalType = try confirmTokenDataType(token)
            try saveJsonValueInJsonArray(jsonArray: &result, token: token, type: lexicalType)
        }
        return result
    }
    
    private func saveJsonValueInJsonArray (jsonArray: inout JsonArray, token: String,  type: LexicalType) throws {
        switch type {
        case .bool :
            if let boolValue = Bool(token) {
                jsonArray.add(value: JsonValue.init(boolValue))
            }
            break
        case .intNumber:
            if let intValue = Int(token) {
                jsonArray.add(value: JsonValue.init(intValue))
            }
        case .string:
            jsonArray.add(value: JsonValue.init(token))
        case .jsonObject:
            let jsonObject =  try handleStringAsJsonObject(token)
            jsonArray.add(value: JsonValue.init(jsonObject))
        case .jsonArray:
            break
        }
    }
    
    func testHandleStringAsJsonArray (_ input: String) -> [String] {
        var queue : Queue <String> = Queue <String>()
        var index = 0
        var element = ""
        while index <= input.count-2 {
            index += 1
            if input[index] == "{" {
                let result = concatenateJsonObjectString(inputString: input, outerIndex: index)
                index = result.innerIndex+1
                queue.add(result.jsonObject)
                continue
            }
            if isTokenCommaBlank(input: input, index: index) && isValidElement(element) {
                queue.add(element)
                element = ""
                continue
            }
            if input[index] != " " {
                element += input[index]
            }
        }
        
        let jsonValueList = queue.toArray()
        XCTAssert(jsonValueList.count > 0, "파싱 실패 : 배열이 비었습니다.")
        return jsonValueList
    }
    
    private func checkInputType ( _ input: String) -> LexicalType {
        var type : LexicalType = LexicalType.string
        let trimInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimInput[trimInput.startIndex] == "[" && trimInput[trimInput.index(before: trimInput.endIndex)] == "]"  {
            type = LexicalType.jsonArray
        }
        if trimInput[trimInput.startIndex] == "{" && trimInput[trimInput.index(before: trimInput.endIndex)] == "}" {
            type = LexicalType.jsonObject
        }
        return type
    }
    
    func concatenateJsonObjectString (inputString : String, outerIndex: Int) -> (jsonObject: String, innerIndex: Int){
        var offset = outerIndex
        var jsonObject = ""
        while inputString[offset] != "}" {
            jsonObject += inputString[offset]
            offset += 1
        }
        jsonObject += inputString[offset]
        return (jsonObject, offset)
    }
    
    func isTokenCommaBlank(input: String, index: Int ) -> Bool {
        return (input[index] == "," || input[index] == " " )
    }
    
    func isValidElement(_ element: String) -> Bool {
        return element != " " && element != ""
    }
    
   
    
    
    /***********************
     *** Lexing Analysis ***
     ***********************
     */
    
    private func decideElementLexicalType( string: Bool = false, number: Bool = false, bool : Bool = false, jsonObject: Bool = false, jsonArray: Bool = false) throws -> LexicalType {
        var result: LexicalType? = string ? LexicalType.string : nil
        result = number ? LexicalType.intNumber : result
        result = bool ? LexicalType.bool : result
        result = jsonObject ? LexicalType.jsonObject : result
        result = jsonArray ? LexicalType.jsonArray : result
        
        guard let resultType = result else {
            throw ErrorCode.lexicalTypeError
        }
        return resultType
    }
    
    private func isString (_ token : String) -> Bool {
        return token.hasPrefix("\"") && token.hasSuffix("\"") ? true : false
    }
    
    private func isNumeric (_ token : String) -> Bool {
        guard let _: Int = Int(token) else {
            return false
        }
        return true
    }
    
    private func isBoolean (_ token : String) -> Bool {
        guard let _: Bool = Bool(token) else {
            return false
        }
        return true
    }
    
    private func isJsonObject (_ token: String) -> Bool {
        return token[0] == "{" && token[token.count-1] == "}"
    }
    
    private func isJsonArray (_ token: String ) -> Bool {
        return token[0] == "[" && token[token.count-1] == "]"
    }
}


