//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by 이진영 on 21/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    private let objectRegex = "^\\{ ?((|, ?)(\"[a-zA-Z0-9]+\" ?: ?)(\"[a-zA-Z0-9 ]+\"|[0-9]+|true|false))+ ?\\}$"
    private let arrayRegex = "^\\[ ?((|, ?)(\"[a-zA-Z0-9 ]+\"|[0-9]+|true|false|(\\{ ?((|, ?)(\"[a-zA-Z0-9]+\" ?: ?)(\"[a-zA-Z0-9 ]+\"|[0-9]+|true|false))+ ?\\})))+ ?\\]$"
    
    func matches(_ value: String) -> Bool {
        return value.range(of: objectRegex, options: .regularExpression) != nil
    }
}
