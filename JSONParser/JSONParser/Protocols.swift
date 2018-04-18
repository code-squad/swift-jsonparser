//
//  Protocols.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol JSONPrintable {
    var total: Int { get }
    
    func countCharacters() -> Int
    func countNumbers() -> Int
    func countBooleans() -> Int
    
    var prefixOfCharacters: String { get }
    var prefixOfNumbers: String { get }
    var prefixOfBooleans: String { get }
}
