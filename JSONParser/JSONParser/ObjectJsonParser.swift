//
//  JsonParser.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 11. 27..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct ObjectJsonParser {
    typealias regex = JsonScanner.regex
    let columnName = [regex.STARTCURLYBRACKET, regex.STRING, regex.COLON, regex.STRING, regex.NUMBER, regex.BOOLEAN, regex.COMMA, regex.ENDCURLYBRACKET]
    var indexOfColumn = 0
    let parsingTableOfObject = [[1, 0, 0, 0, 0, 0, 0, 0],
                                [0, 2, 0, 0, 0, 0, 0, 0],
                                [0, 0, 3, 0, 0, 0, 0, 0],
                                [0, 0, 4, 0, 0, 0, 0, 0],
                                [0, 0, 5, 0, 0, 0, 0, 0],
                                [0, 0, 0, 6, 0, 0, 0, 0],
                                [0, 0, 0, 7, 0, 0, 0, 0],
                                [0, 0, 0, 0, 6, 0, 0, 0],
                                [0, 0, 0, 0, 7, 0, 0, 0],
                                [0, 0, 0, 0, 0, 6, 0, 0],
                                [0, 0, 0, 0, 0, 7, 0, 0],
                                [0, 0, 0, 0, 0, 0, 1, 0],
                                [0, 0, 0, 0, 0, 0, 0, -1]]
    
    func checkJsonSyntax(token: [Token]) throws -> [Token]{
        var nextState = 0
        for tokenValue in token {
            nextState = try gotoMatchState(tokenValue: tokenValue.id, state: nextState)
            print(nextState)
            if token.count-1 == nextState {
                print("종료")
                return makeObjectToken(token: token)
            }
        }
        throw JsonScanner.JsonError.invalidJsonPattern
    }
    
    func gotoMatchState(tokenValue: regex, state: Int) throws -> Int {
        if tokenValue == columnName[indexOfColumn] {
            return findMatchToken(row: state)
        }else {
            return state + 1
        }
    }
    
    func findMatchToken(row: Int) -> Int{
        for col in 0..<parsingTableOfObject[row].count {
            if parsingTableOfObject[row][col] != 0 || parsingTableOfObject[row][col] == -1 {
                return parsingTableOfObject[row][col]
            }
            
        }
        return 0
    }
    
    func makeObjectToken(token: [Token]) -> [Token] {
        var objectToken = [Token]()
        var flag = false
        for tokenValue in token {
            if tokenValue.id == regex.COLON {
                flag = true
            }else if flag {
                objectToken.append(tokenValue)
                flag = false
            }
        }
        return objectToken
    }
    
}
