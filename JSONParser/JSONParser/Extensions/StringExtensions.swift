//
//  StringExtensions.swift
//  JSONParser
//
//  Created by 이동영 on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

extension String {
    var isNumber: Bool { return Int(self) != nil }
    var isBool: Bool { return Bool(self) != nil }
    var isString: Bool { return self.first == "\"" && self.last == "\"" }
    var isWhiteSpace: Bool { return self == " " }
    var isComma: Bool { return self == "," }
    var isColon: Bool { return self == ":"}
    var isDoubleQuotation: Bool { return self == "\"" }
    var isLeftBrace: Bool { return self == "{" }
    var isRightBrace: Bool { return self == "}" }
    var isLeftBraket: Bool { return self == "[" }
    var isRightBraket: Bool { return self == "]" }
}
