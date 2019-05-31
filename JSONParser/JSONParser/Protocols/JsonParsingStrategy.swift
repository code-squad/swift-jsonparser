//
//  Parser.swift
//  JSONParser
//
//  Created by 이동영 on 25/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JsonParsingStrategy {
   func parse(tokens: Array<Token>) -> JsonValue
}
