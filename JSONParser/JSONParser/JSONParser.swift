//
//  JSONParser.swift
//  JSONParser
//
//  Created by 이동건 on 03/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    private (set) var elements: [String]
    private (set) var strings: [String] = []
    private (set) var integers: [Int] = []
    private (set) var booleans: [Bool] = []
    
    
    init(elements: [String]) {
        self.elements = elements
        parse()
    }
    
    mutating private func parse() {
        strings = elements.filter {$0.contains("\"")}
        booleans = elements.compactMap {Bool($0)}
        integers = elements.compactMap {Int($0)}
    }
}
