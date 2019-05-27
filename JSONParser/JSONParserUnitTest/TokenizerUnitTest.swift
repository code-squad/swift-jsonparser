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

    let testInputJsonObject = "[ { \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true }, { \"name\" : \"YOON JISU\", \"alias\" : \"crong\", \"level\" : 4, \"married\" : true }, true, \"context\" ]"
    let testSimpleInput = "[ 10 , \"jk\", 4, \"314\", 99, \"cro ng\", false, [\"json\", \"Array\"], \"[ SquareBr, acke, tTest ]\", {\"abc\" : 10, \"bool\" : true}, \"{, {. [, [, curly , , ] ] ] ] \" ]"
    let testJsonObject = "{ \"name\" : \"KIM JUNG\", \"alias\" : \"JK\", \"level\" : 5, \"married\" : true, \"{ : }\" : \"curly bracket : \", \"curly bracket\":{ \"key\" : value } }"

    /// 5/25 unitTest
    func testWhiteSpaceAndNewLineTokenize() {
        print("======= testWhiteSpaceAndNewLineTokenize ========")
        let whitespaceSplitResult = tokenizedWithWhiteSpace(testSimpleInput)
        print("## test : > \(whitespaceSplitResult.components(separatedBy: ["&"]).filter{!$0.isEmpty})")
        XCTAssert(whitespaceSplitResult.components(separatedBy: "&").count == 20, "actual : \(whitespaceSplitResult.components(separatedBy: "&").count)")
    }
    
    func testCommaTokenize(){
        print("======= testCommaTokenize ========")
        let whitespaceSplitResult = tokenizedWithWhiteSpace(testSimpleInput)
        let commaSplitResult = tokenizedWithComma(whitespaceSplitResult)
        print("## test : > \(commaSplitResult.components(separatedBy: ["@", "&"]).filter{!$0.isEmpty})")
        XCTAssert(commaSplitResult.components(separatedBy: ["@", "&"]).filter{!$0.isEmpty}.count == 19, "actual : \(commaSplitResult.components(separatedBy: "&").count)")
    }

    func testSquareBracket() {
        print("======= testSquareBracket ========")
        let whitespaceSplitResult = tokenizedWithWhiteSpace(testSimpleInput)
        let commaSplitResult = tokenizedWithComma(whitespaceSplitResult)
        let splitSquareBracket = tokenizeWithSquareBrackets(commaSplitResult)
        XCTAssert(splitSquareBracket.components(separatedBy: ["^", "$"]).filter{ !$0.isEmpty }.count == 7, "actual :>  \(splitSquareBracket.components(separatedBy: ["^", "$"]).filter{ !$0.isEmpty }.count)" )
        
        print("## test : > \(splitSquareBracket.components(separatedBy: ["@", "&", "^", "$"]).filter{ !$0.isEmpty })")
        XCTAssert(splitSquareBracket.components(separatedBy: ["@", "&", "^", "$"]).filter{ !$0.isEmpty }.count == 21, "actual count : \(splitSquareBracket.components(separatedBy: ["@", "&", "^", "$"]).filter{ !$0.isEmpty }.count)")
    }
    
    func testCurlyBracket(){
        print("======= testCurlyBracket ========")
        let whitespaceSplitResult = tokenizedWithWhiteSpace(testJsonObject)
        let commaSplitResult = tokenizedWithComma(whitespaceSplitResult)
        let splitCurlyBracket = tokenizeWithCurlyBrackets(commaSplitResult)
        print("result : \(splitCurlyBracket.components(separatedBy: ["^", "$", "&", "@"]).filter{!$0.isEmpty && $0 != " "})")
        XCTAssert(splitCurlyBracket.components(separatedBy: ["^", "$", "&", "@"]).filter{!$0.isEmpty}.count == 23, "actual count : \(splitCurlyBracket.components(separatedBy: ["^", "$", "&", "@"]).filter{!$0.isEmpty}.count)")
    }
    
    /// :
    func testSemicolon(){
        print("======= testSemicolon ========")
        let whitespaceSplitResult = tokenizedWithWhiteSpace(testJsonObject)
        let commaSplitResult = tokenizedWithComma(whitespaceSplitResult)
        let splitCurlyBracket = tokenizeWithCurlyBrackets(commaSplitResult)
        let splitSemicolon = tokenizedWithSemicolon(splitCurlyBracket)
        print("result : \(splitSemicolon.components(separatedBy: ["^", "$", "&", "@", "#"]).filter{!$0.isEmpty})")
        XCTAssert(splitSemicolon.components(separatedBy: ["^", "$", "&", "@", "#"]).filter{!$0.isEmpty}.count == 17, "actual count : \(splitSemicolon.components(separatedBy: ["^", "$", "&", "@", "#"]).filter{!$0.isEmpty}.count)")
    }
    
    private func tokenizedWithSemicolon(_ input: String) -> String {
        let tokens = input.components(separatedBy: ":").joined(separator: "#").trimmingCharacters(in: .whitespacesAndNewlines)
        let result = restoreSplitSingleSymbolInStringQuatation(tokens: tokens, originCharacter: ":", splitCharacter: "#")
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
        let tokens = input.components(separatedBy: ",").joined(separator: "@").trimmingCharacters(in: .whitespacesAndNewlines)
        let result = restoreSplitSingleSymbolInStringQuatation(tokens: tokens, originCharacter: ",", splitCharacter: "@")
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


}


