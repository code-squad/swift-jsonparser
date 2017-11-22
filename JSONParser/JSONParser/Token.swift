//
//  TokenInfo.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct Token {
    var id: JsonScanner.regex
    var value: String
    init(id: JsonScanner.regex, value: String) {
        self.id = id
        self.value = value
    }
}
