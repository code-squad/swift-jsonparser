//
//  TokenGenerater.swift
//  JSONParser
//
//  Created by 이동영 on 23/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TokenGenerater {
    static public func createToken(_ string:String) -> Token {
        return Token.init(type: .String, value: string)
    }
}
