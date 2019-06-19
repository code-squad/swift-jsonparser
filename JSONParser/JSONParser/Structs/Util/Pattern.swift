//
//  Pattern.swift
//  JSONParser
//
//  Created by 이동영 on 18/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

// - MARK: - Default
struct Pattern {
    static let number = "[0-9]+"
    static let bool = "(true|false)"
    static let string = "\"[^\"]*\""
    static let ws = "\\s+"
    static let punctuation = "(\\]|\\[|\\}|\\{|,|:)"
}
// - MARK: - Advanced
extension Pattern {
    static let value = "\(number)|\(bool)|\(string)"
    static let tokens = "(\(value)|\(ws)|\(punctuation))"
}
// - MARK: - Collection
extension Pattern {
    static let keyValue = "\(string)(\(ws))?:(\(ws))?(\(value))"
    static let object = "(\(ws))?\\{((\(ws))?\(keyValue)(\(ws))?(,)?)*\\}(\(ws))?"
    static let list = "\\[((\(ws))?(\(value)|(\(object)))(\(ws))?(,)?(\(ws))?)*\\]"
}
