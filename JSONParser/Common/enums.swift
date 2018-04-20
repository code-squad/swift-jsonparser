//
//  TokenSplitUnit.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 20..
//  Copyright © 2018년 JK. All rights reserved.
//

enum TokenSplitUnit: Character {
    case startBracket = "["
    case endBrackert = "]"
    case comma = ","
}

enum Capsule: String {
    case Bracket = "[]"
}

enum RegexPatten: String {
    case NumberPatten = "[0-9]"
    case StringPatten = "\"[a-z]|[A-Z]\""
    case BooleanPaten = "false|true|FALSE|TRUE"
}
