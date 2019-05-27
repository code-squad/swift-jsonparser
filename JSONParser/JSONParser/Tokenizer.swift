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
    func tokenize(_ input : String) throws -> [String] {
        var tokenList : [String] = [String]()
        print("original : \(input)")
        
        
        
        
        
        
        return tokenList
    }
   
    private func tokenizedWithSemicolon(_ input: String) -> String {
        let tokens = input.components(separatedBy: ":").joined(separator: "#:#").trimmingCharacters(in: .whitespacesAndNewlines)
        let result = restoreSplitPairSymbolInStringQuatation(tokens: tokens, originCharacter: ":", splitCharacter: "#:#")
        return result
    }
    /// " "
    private func tokenizedWithWhiteSpace(_ input: String) -> String{
        let tokens = input.components(separatedBy: .whitespacesAndNewlines).filter {!$0.isEmpty}.joined(separator : "&")
        let result = restoreSplitSingleSymbolInStringQuatation(tokens: tokens, originCharacter: " ", splitCharacter: "&")
        
        return result
    }
    /// ,
    private func tokenizedWithComma(_ input: String) -> String{
        let tokens = input.components(separatedBy: ",").joined(separator: "@,@").trimmingCharacters(in: .whitespacesAndNewlines)
        let result = restoreSplitPairSymbolInStringQuatation(tokens: tokens, originCharacter: ",", splitCharacter: "@,@")
        return result
    }
    
    /// [ ]
    private func tokenizeWithSquareBrackets(_ input: String) -> String {
        var tokens = input.components(separatedBy: "[").joined(separator: "^[^")
        tokens = tokens.components(separatedBy: "]").joined(separator: "$]$")
        var result = restoreSplitPairSymbolInStringQuatation(tokens: tokens, originCharacter: "[", splitCharacter: "^[^")
        result = restoreSplitPairSymbolInStringQuatation(tokens: result, originCharacter: "]", splitCharacter: "$]$")
        return result
    }
    
    private func tokenizeWithCurlyBrackets(_ input: String) -> String {
        var tokens = input.components(separatedBy: "{").joined(separator: "^{^")
        tokens = tokens.components(separatedBy: "}").joined(separator: "$}$")
        var result = restoreSplitPairSymbolInStringQuatation(tokens: tokens, originCharacter: "{", splitCharacter: "^{^")
        result = restoreSplitPairSymbolInStringQuatation(tokens: result, originCharacter: "}", splitCharacter: "$}$")
        return result
    }
    
    private func restoreSplitPairSymbolInStringQuatation(tokens: String, startSeparator : String = "\"", endSeparator: String = "\"", originCharacter: String, splitCharacter: String) -> String {
        var result = ""
        var index = 0
        while index < tokens.count {
            result += tokens[index]
            // \" 를 보았을 경우, stack을 쌓는다.
            if tokens[index] == startSeparator {
                index += 1
                result += complieStackFromBrackets(index: &index, tokens: tokens, end: endSeparator, originCharacter: originCharacter,  splitBy: splitCharacter)
                continue
            }
            index += 1
        }
        return result
    }
    
    private func complieStackFromBrackets (index : inout Int, tokens: String, end: String, originCharacter: String, splitBy splitCharacter : String ) -> String {
        var stack : Stack<String> = Stack<String>()
        stack.push(tokens[index])
        var result = ""
        var innerIndex = index
        // resotreBlockSeparator 가 다시 나올때 까지 stack을 쌓는다.
        while true {
            innerIndex += 1
            /// check ^[^ or $[$ or ^{^ or ${$ and push stack except ^ or $
            if ( innerIndex - 2 >= 0 && tokens[innerIndex - 2] == splitCharacter[0] &&
                tokens[innerIndex - 1] == splitCharacter[1] && tokens[innerIndex ] == splitCharacter[2]){
                guard let bracket = stack.pop() else {
                    continue
                }
                stack.pop()         // pop ^ or  $
                stack.push(bracket) // push [ ] { }
                continue
            }
            ///else
            stack.push(tokens[innerIndex])
            if tokens[innerIndex] == end {      // ""\"
                result += popAllStackAsFIFO(stack)
                index = innerIndex + 1
                break
            }
        }
        return result
    }
    
    private func restoreSplitSingleSymbolInStringQuatation(tokens: String, startSeparator : String = "\"", endSeparator: String = "\"", originCharacter: String, splitCharacter: String) -> String {
        var result = ""
        var index = 0
        while index < tokens.count {
            result += tokens[index]
            // \" 를 보았을 경우, stack을 쌓는다.
            if tokens[index] == startSeparator {
                index += 1
                result += complieStackBetweenRestoreBlock(index: &index, tokens: tokens, end: endSeparator, originCharacter: originCharacter,  splitBy: splitCharacter)
                continue
            }
            index += 1
        }
        return result
    }
    
    private func complieStackBetweenRestoreBlock (index : inout Int, tokens: String, end: String, originCharacter: String, splitBy splitCharacter : String ) -> String {
        var stack : Stack<String> = Stack<String>()
        stack.push(tokens[index])
        var result = ""
        var innerIndex = index
        // resotreBlockSeparator 가 다시 나올때 까지 stack을 쌓는다.
        while true {
            innerIndex += 1
            tokens[innerIndex] == splitCharacter ? stack.push(originCharacter) : stack.push(tokens[innerIndex])
            if tokens[innerIndex] == end {
                index = innerIndex + 1
                result += popAllStackAsFIFO(stack)
                index = innerIndex + 1
                break
            }
        }
        return result
    }
    
    private func popAllStackAsFIFO(_ input: Stack<String> ) -> String {
        var result = ""
        var stack = input
        while !stack.isEmpty() {
            guard let popValue = stack.pop() else {
                continue
            }
            result =  popValue + result
        }
        return result
    }

//    func tokenize(_ input : String) throws -> [JsonParsable] {
//        var result : JsonParsable
//        let type = Lexer.checkInputType(input)
//        switch type {
//        case .jsonObject:
//            result = try handleStringAsJsonObject(input)
//            break
//        case .jsonArray:
//            let jsonArray = handleStringAsJsonArray(input)
//            result = try convertJsonArrayElementDataType(tokenList: jsonArray)
//            break
//        default :
//            throw ErrorCode.invalidJsonFormat
//        }
//        return result
//    }
//
//    private func handleStringAsJsonObject(_ input: String) throws -> JsonParsable {
//        let trimmedInput = input[1..<input.count-1]
//        let keyValueList = trimmedInput.components(separatedBy: TokenSplitStandard.comma.rawValue)
//        var keys: [String] = [String]()
//        var values: [JsonParsable] = [JsonParsable]()
//        for eachKeyValue in keyValueList{
//            let keyValuePair: [String] = eachKeyValue
//                                                .components(separatedBy: TokenSplitStandard.semicolon.rawValue)
//                                                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines)}
//            let valueDataType = try convertJsonObjectStringValueToElementDataType(keyValuePair[1])
//            keys.append(keyValuePair[0])
//            values.append(valueDataType)
//        }
//        let jsonObject: JsonObject = JsonObject.init(keys: keys, values: values)
//        return jsonObject
//    }
//    
//    /// subroutine of jsonObject
//    private func convertJsonObjectStringValueToElementDataType(_ tokenValue : String ) throws -> JsonParsable {
//        let lexicalType = try Lexer.confirmTokenDataType(tokenValue)
//        let result : JsonParsable = createJsonValueFromJsonObject(type: lexicalType, token: tokenValue)
//        return result
//    }
//    
//    /// subroutine of jsonArray
//    private func convertJsonArrayElementDataType (tokenList : [String]) throws -> JsonParsable{
//        var result = JsonArray()
//        for token in tokenList {
//            let lexicalType = try Lexer.confirmTokenDataType(token)
//            try saveJsonValueInJsonArray(jsonArray: &result, token: token, type: lexicalType)
//        }
//        return result
//    }
//    
//    private func createJsonValueFromJsonObject (type: LexicalType, token : String ) -> JsonParsable {
//        var result : JsonParsable = token
//        switch type {
//        case .bool :
//            if let boolValue = Bool(token) {
//                result = boolValue
//            }
//        case .intNumber:
//            if let intValue = Int(token) {
//                result = intValue
//            }
//        default :
//            break
//        }
//        return result
//    }
//    
//    private func saveJsonValueInJsonArray (jsonArray: inout JsonArray, token: String,  type: LexicalType) throws {
//        switch type {
//        case .bool :
//            if let boolValue = Bool(token) {
//                jsonArray.add(value: boolValue)
//            }
//            break
//        case .intNumber:
//            if let intValue = Int(token) {
//                jsonArray.add(value: intValue)
//            }
//        case .string:
//            jsonArray.add(value: token)
//        case .jsonObject:
//            let jsonObject =  try handleStringAsJsonObject(token)
//            jsonArray.add(value: jsonObject)
//        case .jsonArray:
//            break
//        }
//    }
//    
//    private func handleStringAsJsonArray (_ input: String) -> [String] {
//        var queue : Queue <String> = Queue <String>()
//        var index = 0
//        var element = ""
//        while index <= input.count-2 {
//            index += 1
//            if input[index] == JsonBrackets.StartCurlyBrace.rawValue {
//                let result = concatenateJsonObjectString(inputString: input, outerIndex: index)
//                index = result.innerIndex+1
//                queue.add(result.jsonObject)
//                continue
//            }
//            if isTokenCommaBlank(input: input, index: index) && isValidElement(element) {
//                queue.add(element)
//                element = ""
//                continue
//            }
//            if input[index] != TokenSplitStandard.whitespace.rawValue {
//                element += input[index]
//            }
//        }
//        let jsonValueList = queue.toArray()
//        return jsonValueList
//    }
//    
//    private func concatenateJsonObjectString (inputString : String, outerIndex: Int) -> (jsonObject: String, innerIndex: Int){
//        var offset = outerIndex
//        var jsonObject = ""
//        while inputString[offset] != JsonBrackets.EndCurlyBrace.rawValue {
//            jsonObject += inputString[offset]
//            offset += 1
//        }
//        jsonObject += inputString[offset]
//        return (jsonObject, offset)
//    }
//    
//    private func isTokenCommaBlank(input: String, index: Int ) -> Bool {
//        return (input[index] == TokenSplitStandard.comma.rawValue || input[index] == TokenSplitStandard.whitespace.rawValue )
//    }
//    
//    private func isValidElement(_ element: String) -> Bool {
//        return element != TokenSplitStandard.whitespace.rawValue && element != ""
//    }
    
}
