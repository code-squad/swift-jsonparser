//
//  JsonParser.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 11. 27..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct ObjectJsonParser: FirstObject {
    typealias regex = JsonScanner.regex
    let type = "객체"
    let columnName = [regex.STARTCURLYBRACKET, regex.STRING, regex.COLON, regex.STARTSQUAREBRACKET, regex.STRING, regex.NUMBER, regex.BOOLEAN, regex.ENDSQUAREBRACKET, regex.COMMA, regex.ENDCURLYBRACKET]
    let parsingTableOfObject = [[1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                                [0 ,2, 0, 0, 0, 0, 0, 0, 0, 0],
                                [0, 0, 3, 0, 0, 0, 0, 0, 0, 0],
                                [0, 0, 4, 0, 0, 0, 0, 0, 0, 0],
                                [0, 0, 5, 0, 0, 0, 0, 0, 0, 0],
                                [0, 0, 6, 0, 0, 0, 0, 0, 0, 0],
                                [0, 0, 0, 7, 0, 0, 0, 0, 0, 0],
                                [0, 0, 0, 0, 8, 0, 0, 0, 0, 0],
                                [0, 0, 0, 0, 9, 0, 0, 0, 0, 0],
                                [0, 0, 0, 0, 0, 8, 0, 0, 0, 0],
                                [0, 0, 0, 0, 0, 9, 0, 0, 0, 0],
                                [0, 0, 0, 0, 0, 0, 8, 0, 0, 0],
                                [0, 0, 0, 0, 0, 0, 9, 0, 0, 0],
                                [0, 0, 0, 0, 0, 0, 0, 8, 0, 0],
                                [0, 0, 0, 0, 0, 0, 0, 9, 0, 0],
                                [0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
                                [0, 0, 0, 0, 0, 0, 0, 0, 0, -1]]
    
    func goToArrayJsonParser(token: [Token], index: Int, stack: JsonStack) -> Int {
        var objectToken = [Token]()
        let arrayJsonParser = ArrayJsonParser()
        var currentIndex = 0
        for tokenIndex in index..<token.count {
            objectToken.append(token[tokenIndex])
            if token[tokenIndex].id == regex.ENDSQUAREBRACKET {
                arrayJsonParser.checkJsonSyntax(token: objectToken, stack: stack)
                currentIndex = tokenIndex
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
        for row in 0..<parsingTableOfObject.count {
            for col in 0..<parsingTableOfObject[row].count {
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
        if parsingTableOfObject[row][col] != 0 {
            if columnName[col] == token[tokenIndex].id {
                jsonStack.push(tokenData: token[tokenIndex])
                indexOfNextRegex = parsingTableOfObject[row][col]
                indexOfToken += 1
                if columnName[col] == regex.STARTSQUAREBRACKET {
                    indexOfToken += goToArrayJsonParser(token: token, index: indexOfToken, stack: jsonStack)
                }else if columnName[col] == regex.COMMA {
                    return (indexOfToken, indexOfNextRegex, -1, jsonStack)
                }
            }
        }
        return (indexOfToken, indexOfNextRegex, row, jsonStack)
    }
    
}

