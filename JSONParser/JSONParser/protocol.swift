//
//  protocol.swift
//  JSONParser
//
//  Created by 김장수 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol Parsable {
    func name() -> String
    func countEachJSON() -> (int: Int, bool: Int, string: Int, array: Int, object: Int, total: Int)
}
