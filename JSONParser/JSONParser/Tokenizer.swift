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
    func tokenize(_ input : String) -> [String] {
        var tokenList : [String] = [String]()
        var result = tokenizeWithWhiteSpace(input)
        result = tokenizeWithComma(result)
        result = tokenizeWithSquareBrackets(result)
        result = tokenizeWithCurlyBrackets(result)
        result = tokenizeWithSemicolon(result)
        tokenList = result.components(separatedBy: ["^", "$", "&", "@", "#"]).filter{!$0.isEmpty}
        
        return tokenList
    }
    
    private func tokenizeWithSemicolon(_ input: String) -> String {
        let tokens = input.components(separatedBy: ":").joined(separator: "#:#").trimmingCharacters(in: .whitespacesAndNewlines)
        let result = restoreSplitPairSymbolInStringQuatation(tokens: tokens, originCharacter: ":", splitCharacter: "#:#")
        return result
    }
    
    /// " "
    private func tokenizeWithWhiteSpace(_ input: String) -> String{
        let tokens = input.components(separatedBy: .whitespacesAndNewlines).filter {!$0.isEmpty}.joined(separator : "&")
        let result = restoreSplitSingleSymbolInStringQuatation(tokens: tokens, originCharacter: " ", splitCharacter: "&")
        
        return result
    }
    
    /// ,
    private func tokenizeWithComma(_ input: String) -> String{
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
                result += compileStackFromBrackets(index: &index, tokens: tokens, end: endSeparator, originCharacter: originCharacter, splitBy: splitCharacter)
                continue
            }
            index += 1
        }
        return result
    }
    
    private func compileStackFromBrackets (index : inout Int, tokens: String, end: String, originCharacter: String, splitBy splitCharacter : String ) -> String {
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
            /// else
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
            /// \" 를 보았을 경우, stack을 쌓는다.
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
        /// resotreBlockSeparator 가 다시 나올때 까지 stack을 쌓는다.
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
