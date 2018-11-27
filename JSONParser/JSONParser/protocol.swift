//
//  protocol.swift
//  JSONParser
//
//  Created by 김장수 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol JSONFormat {
    func typeName() -> String
    func typeTotal() -> Int
    func countsEachData() -> (int: Int, bool: Int, string: Int, array: Int, object: Int)
    func bringContents() -> String
    func bringBracket() -> (left: String, right: String)
}
