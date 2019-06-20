//
//  Reader.swift
//  JSONParser
//
//  Created by BLU on 20/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Reader<T> {
    
    private let elements: [T]
    private(set) var position = 0
    
    init(elements: [T]) {
        self.elements = elements
    }
    
    mutating func peek() -> T? {
        guard position < elements.endIndex else {
            return nil
        }
        return elements[position]
    }
    
    mutating func advance() {
        position = position + 1
    }
}
