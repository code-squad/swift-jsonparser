//
//  Protocols.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol Parsable {
    var numbers: [Int] { get set }
    var characters: [String] { get set }
    var booleans: [Bool] { get set }
    var total: Int { get }
}
