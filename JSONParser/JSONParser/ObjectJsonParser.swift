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
    private var objectOfJsonData = [String:Any]() //Dictionary<String,Any>
    private var tokenOfJson = [Token]()
    private var indexOfToken: Int = 0
    private var indexOfNextRegex: Int = 0
    private var value: Any = ""
    private var key: String = ""
    var isKey = false, isValue = false
    private let columnName = [regex.STARTCURLYBRACKET, regex.STRING, regex.COLON, regex.STARTSQUAREBRACKET, regex.STRING, regex.NUMBER, regex.BOOLEAN, regex.ENDSQUAREBRACKET, regex.COMMA, regex.ENDCURLYBRACKET]
    private let parsingTableOfObject = [[1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
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
    
    mutating func makeJsonData(token: [Token]) -> [String:Any] {
        tokenOfJson = token
        while indexOfToken < tokenOfJson.count {
            let terminator = compareToParsingTable()
            if terminator == -2 {
                break
            }
        }
        return objectOfJsonData
    }

    mutating func compareToParsingTable() -> Int {
        for row in 0..<parsingTableOfObject.count {
            for col in 0..<parsingTableOfObject[row].count {
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
        guard parsingTableOfObject[row][col] != 0 else { return row }
        guard columnName[col] == tokenOfJson[indexOfToken].id else { return row }
        if isKey {
            key = tokenOfJson[indexOfToken].value as! String
            isKey = false
        }else if isValue {
            fetchTheValue(col: col)
        }
        if columnName[col] == regex.STARTCURLYBRACKET || columnName[col] == regex.COMMA {
            isKey = true
        }else if columnName[col] == regex.COLON || columnName[col] == regex.STARTCURLYBRACKET {
            if columnName[col+1] == regex.STARTCURLYBRACKET {
                isValue = false
            }else {
                isValue = true
            }
        }
        indexOfNextRegex = parsingTableOfObject[row][col]
        indexOfToken += 1
        if columnName[col] == regex.COMMA {
            return -1
        }else if columnName[col] == regex.ENDCURLYBRACKET {
            return -2
        }
        return row
    }
    
    mutating func fetchTheValue(col: Int) {
        if columnName[col] == regex.STARTSQUAREBRACKET {
            let tokenOfSplit = tokenOfJson[indexOfToken..<tokenOfJson.count]
            var arrayJsonParser = ArrayJsonParser()
            let jsonData = arrayJsonParser.makeJsonData(token: Array(tokenOfSplit))
            value = jsonData
        }else if columnName[col] == regex.STARTCURLYBRACKET {
            let tokenOfSplit = tokenOfJson[indexOfToken..<tokenOfJson.count]
            var objectJsonParser = ObjectJsonParser()
            let jsonData = objectJsonParser.makeJsonData(token: Array(tokenOfSplit))
            value = jsonData
            indexOfToken = indexOfToken + ( jsonData.count * 3 ) * 2
        }else {
            value = tokenOfJson[indexOfToken].value
        }
        objectOfJsonData[key] = value
        isValue = false
    }
    
}
