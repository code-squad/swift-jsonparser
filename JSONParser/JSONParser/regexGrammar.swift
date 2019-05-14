//
//  regexGrammar.swift
//  JSONParser
//
//  Created by joon-ho kil on 5/14/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum regexGrammar: String {
    case object = "\\{[A-z\"0-9:., ]+\\}"
    case array = "\\[[A-z\"0-9., ]+\\]"
}
