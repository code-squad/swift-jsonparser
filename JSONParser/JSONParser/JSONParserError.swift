//
//  Error.swift
//  JSONParser
//
//  Created by 이동건 on 14/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum JSONParserError: Error {
    case invalidInput
    case invalidFormat
    case unexpected
}
