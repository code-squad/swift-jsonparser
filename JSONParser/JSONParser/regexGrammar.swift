//
//  regexGrammar.swift
//  JSONParser
//
//  Created by joon-ho kil on 5/14/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum RegexGrammar: String {
    case object = "\\{ \"[\\d\\w' ]+\" \\: (\\[(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))*\\]|\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\" \\: (\\[(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))*\\]|\"[\\d\\w' ]+\"|true|false|\\d+)))* \\}"
    case array = "\\[ (\\[ {0,1}(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))* {0,1}\\]|\"[\\d\\w' ]+\"|true|false|\\d+|\\{ \"[\\d\\w' ]+\" \\: (\"[\\d\\w' ]+\"|true|false|\\d+)(, (\\[ {0,1}(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))* {0,1}\\]|\"[\\d\\w' ]+\" \\: (\"[\\d\\w' ]+\"|true|false|\\d+)))* \\})(, (\"[\\d\\w' ]+\"|true|false|\\d+|\\{ \"[\\d\\w' ]+\" \\: (\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\" \\: (\"[\\d\\w' ]+\"|true|false|\\d+)))* \\}))* \\]"
    case elementsFromObject = "\"[\\d\\w' ]+\" \\: (\\[(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))*\\]|\"[\\d\\w' ]+\"|true|false|\\d+)"
    case elementsFromArray = "\\[ {0,1}(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))* {0,1}\\]|\\{ \"[\\d\\w' ]+\" \\: (\\[(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))*\\]|\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\" \\: (\\[(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))*\\]|\"[\\d\\w' ]+\"|true|false|\\d+)))* \\}|\"[\\d\\w ]+\"|true|false|\\d+)"
    case elementsFromArrayInArray = "(\\{ \"[\\d\\w' ]+\" \\: (\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\" \\: (\\[(\"[\\d\\w' ]+\"|true|false|\\d+)(, (\"[\\d\\w' ]+\"|true|false|\\d+))*\\]|\"[\\d\\w' ]+\"|true|false|\\d+)))* \\}|\"[\\d\\w ]+\"|true|false|\\d+)"
}
