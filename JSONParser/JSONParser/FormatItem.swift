//
//  JSONArrayFormat.swift
//  JSONParser
//
//  Created by 이희찬 on 03/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol HasFormatItem {
    var container: CharacterSet { get }
    var containerOpen:Character { get }
    var containerClose:Character { get }
    var blank: Character { get }
    var elementSeparator: String { get }
}

struct Array:HasFormatItem {
    var container = CharacterSet(charactersIn: "[]")
    var containerOpen:Character = "["
    var containerClose:Character = "]"
    var blank: Character = " "
    var elementSeparator = ","
}

struct Object:HasFormatItem {
    var container = CharacterSet(charactersIn: "{}")
    var containerOpen:Character = "{"
    var containerClose:Character = "}"
    var blank: Character = " "
    var elementSeparator = ","
}

struct TypeCriterion {
    static let String = CharacterSet(charactersIn: "\"")
    static let Int = CharacterSet.decimalDigits
    static let Bool = (true:"true", false:"false")
}
