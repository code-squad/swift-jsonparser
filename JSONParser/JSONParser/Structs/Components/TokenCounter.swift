//
//  TokenCounter.swift
//  JSONParser
//
//  Created by 이동영 on 23/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TokenCounter {
    
    static func count(tokens:[Token]) -> [TokenType: Int]{
        var numOf = [TokenType: Int]()
        _ = tokens.map{
            numOf[$0.type] = numOf[$0.type] ?? 0 + 1
        }
        return numOf
    }
}
