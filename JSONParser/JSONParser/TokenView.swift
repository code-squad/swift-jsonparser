//
//  TokenView.swift
//  JSONParser
//
//  Created by Daheen Lee on 20/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TokenView {
    private var index = 0
    private var tokens: [String]
    
    init(tokens: [String]) {
        self.tokens = tokens
    }
    
    func hasNext() -> Bool {
        let nextIndex = index + 1
        return nextIndex < tokens.count
    }
    
    mutating func next() -> String? {
        var nextToken: String?
        let nextIndex = index + 1
        
        if (nextIndex < tokens.count) {
            nextToken = tokens[nextIndex]
            index += 1
        }
        return nextToken
    }
}
