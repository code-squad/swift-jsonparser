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
    // CB, BLANK, STRING, COLON, VALUE, COMMA, CB`, $ | Object, jsonValue
    let parsingTableOfObject = [[1, 2, 0, 0, 0, 0, 4, 0, 0, 3, 0],
                                [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                                [0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                                [0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 7],
                                [0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0],
                                [0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0],
                                [0, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0],
                                [0, 0, 9, 10, 11, 0, 0, 0, 0, 0, 0],
                                [0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0],
                                [0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0],
                                [0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0],
                                [0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0],
                                [0, 0, 0, 0, 0, -7, 0, 0, 0, 3, 0]]
    
}
