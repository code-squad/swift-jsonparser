//
//  ArrayJsonParser.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 12. 4..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation
struct ArrayJsonParser {
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
}
