//
//  Tokenizer.swift
//  JSONParser
//
//  Created by hw on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//
// https://stackoverflow.com/questions/380455/looking-for-a-clear-definition-of-what-a-tokenizer-parser-and-lexers-are
// A tokenizer breaks a stream of text into tokens, usually by looking for whitespace (tabs, spaces, new lines).
// A lexer is basically a tokenizer, but it usually attaches extra context to the tokens -- this token is a number,
// that token is a string literal, this other token is an equality operator.
// A parser takes the stream of tokens from the lexer and turns it into an abstract syntax tree
// representing the (usually) program represented by the original text.

import Foundation

struct Tokenizer {
    
    func tokenize(_ input : String) throws -> JsonParsable {
        var result : JsonParsable
        let type = Lexer.checkInputType(input)
        switch type {
        case .jsonObject:
            result = try handleStringAsJsonObject(input)
            break
        case .jsonArray:
            let jsonArray = handleStringAsJsonArray(input)
            result = try convertJsonArrayElementDataType(tokenList: jsonArray)
            break
        default :
            throw ErrorCode.invalidJsonFormat
        }
        return result
    }
    
    private func handleStringAsJsonObject(_ input: String) throws -> JsonParsable {
        let trimmedInput = input[1..<input.count-1]
        let keyValueList = trimmedInput.components(separatedBy: TokenSplitStandard.comma.rawValue)
        var keys: [String] = [String]()
        var values: [JsonValue] = [JsonValue]()
        for eachKeyValue in keyValueList{
            let keyValuePair: [String] = eachKeyValue
                                                .components(separatedBy: TokenSplitStandard.semicolon.rawValue)
                                                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines)}
            let valueDataType = try convertJsonObjectStringValueToElementDataType(keyValuePair[1])
            keys.append(keyValuePair[0])
            values.append(valueDataType)
        }
        let jsonObject: JsonObject = JsonObject.init(keys: keys, values: values)
        return jsonObject
    }
    
    /// subroutine of jsonObject
    private func convertJsonObjectStringValueToElementDataType(_ tokenValue : String ) throws -> JsonValue {
        let lexicalType = try Lexer.confirmTokenDataType(tokenValue)
        let result : JsonValue = createJsonValueFromJsonObject(type: lexicalType, token: tokenValue)
        return result
    }
    
    /// subroutine of jsonArray
    private func convertJsonArrayElementDataType (tokenList : [String]) throws -> JsonParsable{
        var result = JsonArray()
        for token in tokenList {
            let lexicalType = try Lexer.confirmTokenDataType(token)
            try saveJsonValueInJsonArray(jsonArray: &result, token: token, type: lexicalType)
        }
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
    
    private func handleStringAsJsonArray (_ input: String) -> [String] {
        var queue : Queue <String> = Queue <String>()
        var index = 0
        var element = ""
        while index <= input.count-2 {
            index += 1
            if input[index] == JsonBrackets.StartCurlyBrace.rawValue {
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
            if input[index] != TokenSplitStandard.whitespace.rawValue {
                element += input[index]
            }
        }
        let jsonValueList = queue.toArray()
        return jsonValueList
    }
    
    func concatenateJsonObjectString (inputString : String, outerIndex: Int) -> (jsonObject: String, innerIndex: Int){
        var offset = outerIndex
        var jsonObject = ""
        while inputString[offset] != JsonBrackets.EndCurlyBrace.rawValue {
            jsonObject += inputString[offset]
            offset += 1
        }
        jsonObject += inputString[offset]
        return (jsonObject, offset)
    }
    
    func isTokenCommaBlank(input: String, index: Int ) -> Bool {
        return (input[index] == TokenSplitStandard.comma.rawValue || input[index] == TokenSplitStandard.whitespace.rawValue )
    }
    
    func isValidElement(_ element: String) -> Bool {
        return element != TokenSplitStandard.whitespace.rawValue && element != ""
    }
    
}
