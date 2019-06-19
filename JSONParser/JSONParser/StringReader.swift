//
//  Reader.swift
//  JSONParser
//
//  Created by BLU on 16/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct StringReader: Reader {
    
    private let input: String
    private(set) var position: String.Index
    
    init(input: String) {
        self.input = input
        self.position = self.input.startIndex
    }
    
    mutating func peek() -> Character? {
        guard position < input.endIndex else {
            return nil
        }
        return input[position]
    }
    
    mutating func advance() {
        position = input.index(after: position)
    }
}
