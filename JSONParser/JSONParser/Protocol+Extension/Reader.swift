//
//  Reader.swift
//  JSONParser
//
//  Created by BLU on 19/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Reader {
    associatedtype T
    mutating func peek() -> T?
    mutating func advance()
}
