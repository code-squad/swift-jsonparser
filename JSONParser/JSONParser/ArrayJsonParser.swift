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
    var indexOfColumn = 0
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
        var regexIndex = 0
        var tokenIndex = 0
outer:  for _ in 0..<token.count {
inner:      for row in 0..<parsingTableOfArray.count {
                for col in 0..<parsingTableOfArray[row].count {
                    if parsingTableOfArray[row][col] != 0 {
                        if tokenIndex >= token.count {
                            break outer
                        }
                        if token[tokenIndex].id == columnName[regexIndex]{
                            if token[tokenIndex].id == regex.STARTCURLYBRACKET {
                                let index = goToObjectJsonParser(token: token, index: tokenIndex, stack: jsonStack)
                                tokenIndex += index
                            }
                            if token[tokenIndex].id == regex.COMMA {
                                regexIndex = 1
                                tokenIndex += 1
                                break inner
                            }
                            jsonStack.push(tokenData: token[tokenIndex])
                            regexIndex = parsingTableOfArray[row][col]
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
