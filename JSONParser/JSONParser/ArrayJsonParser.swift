
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
    private(set) var type = "배열"
    private var arrayOfJsonData = [Any]() //Array<Any>
    private var tokenOfJson: [Token]
    private var indexOfToken: Int = 0
    private var indexOfNextRegex: Int = 0
    private var countOfRepeat = 0
    private let columnName = [regex.STARTSQUAREBRACKET, regex.STARTCURLYBRACKET, regex.STRING, regex.NUMBER, regex.BOOLEAN, regex.ENDCURLYBRACKET, regex.COMMA, regex.ENDSQUAREBRACKET]
    private let parsingTableOfArray = [[1, 0, 0, 0, 0, 0, 0, 0],
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
    
    init(token: [Token]) {
        tokenOfJson = token
    }
    
    mutating func makeJsonData() -> [Any] {
        while indexOfToken < tokenOfJson.count {
            let terminator = compareToParsingTable()
            if terminator == -2 {
                break
            }
        }
        return arrayOfJsonData
    }
    
    mutating func compareToParsingTable() -> Int {
        for row in 0..<parsingTableOfArray.count {
            for col in 0..<parsingTableOfArray[row].count {
                let valueOfRow = searchNextRegexIndex(row: row, col: col)
                if valueOfRow == -1 {
                    return 0
                }else if valueOfRow == -2 {
                    return -2
                }
            }
        }
        return 0
    }
    
    mutating func searchNextRegexIndex(row: Int, col: Int) -> Int {
        guard parsingTableOfArray[row][col] != 0 else { return row }
        guard columnName[col] == tokenOfJson[indexOfToken].id else { return row }
        if columnName[col] == regex.NUMBER || columnName[col] == regex.BOOLEAN || columnName[col] == regex.STRING {
            arrayOfJsonData.append(tokenOfJson[indexOfToken].value)
        }
        indexOfNextRegex = parsingTableOfArray[row][col]
        indexOfToken += 1
        if columnName[col] == regex.STARTCURLYBRACKET {
            let tokenOfSplit = tokenOfJson[indexOfToken..<tokenOfJson.count]
            var objectJsonParser = ObjectJsonParser(token: Array(tokenOfSplit))
            let jsonData = objectJsonParser.makeJsonData()
            arrayOfJsonData.append(jsonData)
            indexOfToken = indexOfToken + ( jsonData.count * 3 ) + ( jsonData.count - 1 )
            return row
        }else if columnName[col] == regex.STARTSQUAREBRACKET {
            if countOfRepeat > 0 {
                let tokenOfSplit = tokenOfJson[indexOfToken..<tokenOfJson.count]
                var arrayJsonParser = ArrayJsonParser(token: Array(tokenOfSplit))
                let jsonData = arrayJsonParser.makeJsonData()
                arrayOfJsonData.append(jsonData)
                indexOfToken += (jsonData.count + ( jsonData.count - 1 ))
            }
            countOfRepeat += 1
        }else if columnName[col] == regex.COMMA {
            return -1
        }else if columnName[col] == regex.ENDSQUAREBRACKET {
            return -2
        }
        return row
    }
    
}
