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
    var indexOfColumn = 0
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
        let tokenValue = token.map({$0})
        var currentIndex = 0
        for tokenIndex in index..<token.count {
            objectToken.append(tokenValue[tokenIndex])
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
        var regexIndex = 0
        var tokenIndex = 0
        var tokenValue = token.map({$0})
outer:  while tokenIndex < token.count {
inner:      for row in 0..<parsingTableOfObject.count {
                for col in 0..<parsingTableOfObject[row].count {
                    if parsingTableOfObject[row][col] != 0 {
                        if tokenIndex >= token.count {
                            break outer
                        }
                        if tokenValue[tokenIndex].id == columnName[regexIndex]{
                            print(columnName[regexIndex])
                            jsonStack.push(tokenData: tokenValue[tokenIndex])
                            if tokenValue[tokenIndex].id == regex.STARTSQUAREBRACKET {
                                let index = goToArrayJsonParser(token: token, index: tokenIndex, stack: jsonStack)
                                tokenIndex += index
                            }
                            if tokenValue[tokenIndex].id == regex.COMMA {
                                regexIndex = 1
                                tokenIndex += 1
                                break inner
                            }
                            regexIndex = parsingTableOfObject[row][col]
                            tokenIndex += 1
                            break
                        }else {
                            regexIndex += 1
                            if regexIndex >= columnName.count {
                                regexIndex = 1
                            }
                            break
                        }
                    }
                }
            }
        }
    }
    
}

