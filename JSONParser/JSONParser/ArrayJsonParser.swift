//
//  ArrayJsonParser.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 12. 4..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation
struct ArrayJsonParser: FirstObject {
    typealias regex = JsonScanner.regex
    let type = "배열"
    let columnName = [regex.STARTSQUAREBRACKET, regex.STARTCURLYBRACKET, regex.STRING, regex.NUMBER, regex.BOOLEAN, regex.ENDCURLYBRACKET, regex.COMMA, regex.ENDSQUAREBRACKET]
    let parsingTableOfArray = [[1, 0, 0, 0, 0, 0, 0, 0],
                                [2, 0, 0, 0, 0, 0, 0, 0],
                                [3, 0, 0, 0, 0, 0, 0, 0],
                                [4, 0, 0, 0, 0, 0, 0, 0],
                                [0, 5, 0, 0, 0, 0, 0, 0],
                                [0, 0, 6, 0, 0, 0, 0, 0],
                                [0, 0, 7, 0, 0, 0, 0, 0],
                                [0, 0, 0, 6, 0, 0, 0, 0],
                                [0, 0, 0, 7, 0, 0, 0, 0],
                                [0, 0, 0, 0, 6, 0, 0, 0],
                                [0, 0, 0, 0, 7, 0, 0, 0],
                                [0, 0, 0, 0, 0, 6, 0, 0],
                                [0, 0, 0, 0, 0, 7, 0, 0],
                                [0, 0, 0, 0, 0, 0, 1, 0],
                                [0, 0, 0, 0, 0, 0, 2, 0],
                                [0, 0, 0, 0, 0, 0, 3, 0],
                                [0, 0, 0, 0, 0, 0, 4, 0],
                                [0, 0, 0, 0, 0, 0, 0, -1]]
    
    func goToObjectJsonParser(token: [Token], index: Int, stack: JsonStack) -> Int {
        var objectToken = [Token]()
        let objectJsonParser = ObjectJsonParser()
        var currentIndex = 0
        for tokenIndex in index..<token.count {
            objectToken.append(token[tokenIndex])
            if token[tokenIndex].id == regex.ENDCURLYBRACKET {
                objectJsonParser.checkJsonSyntax(token: objectToken, stack: stack)
                currentIndex = tokenIndex - index
                break
            }
        }
        return currentIndex
    }
    
    func checkJsonSyntax(token: [Token], stack: JsonStack) {
        var tokenIndex = 0
        var nextRegexIndex = 0
        let jsonStack = stack
        while tokenIndex < token.count {
            let indexes = compareToParsingTable(token: token, tokenIndex: tokenIndex, nextRegexIndex: nextRegexIndex, stack: jsonStack)
            tokenIndex = indexes.tokenIndex
            nextRegexIndex = indexes.nextRegexIndex
        }
    }
    
    func compareToParsingTable(token: [Token], tokenIndex: Int, nextRegexIndex: Int, stack: JsonStack) -> (tokenIndex: Int, nextRegexIndex: Int, stack: JsonStack) {
        var indexOfToken = tokenIndex
        var indexOfNextRegex = nextRegexIndex
        for row in 0..<parsingTableOfArray.count {
            for col in 0..<parsingTableOfArray[row].count {
                let indexes = searchNextRegexIndex(token: token, tokenIndex: indexOfToken, nextRegexIndex: indexOfNextRegex, row: row, col: col, stack: jsonStack)
                indexOfToken = indexes.tokenIndex
                indexOfNextRegex = indexes.nextRegexIndex
                jsonStack = indexes.stack
                if indexes.row == -1 {
                    return (indexOfToken, indexOfNextRegex, jsonStack)
                }
            }
        }
        return (indexOfToken, indexOfNextRegex, jsonStack)
    }
    
    func searchNextRegexIndex(token: [Token], tokenIndex: Int, nextRegexIndex: Int, row: Int, col: Int, stack: JsonStack) -> (tokenIndex: Int, nextRegexIndex: Int, row: Int, stack: JsonStack) {
        var indexOfToken = tokenIndex
        var indexOfNextRegex = nextRegexIndex
        var jsonStack = stack
        if parsingTableOfArray[row][col] != 0 {
            if columnName[col] == token[tokenIndex].id {
                jsonStack.push(tokenData: token[tokenIndex])
                indexOfNextRegex = parsingTableOfArray[row][col]
                indexOfToken += 1
                if columnName[col] == regex.STARTCURLYBRACKET {
                    indexOfToken += goToObjectJsonParser(token: token, index: indexOfToken, stack: jsonStack)
                }else if columnName[col] == regex.COMMA {
                    return (indexOfToken, indexOfNextRegex, -1, jsonStack)
                }
            }
        }
        return (indexOfToken, indexOfNextRegex, row, jsonStack)
    }
    
}
