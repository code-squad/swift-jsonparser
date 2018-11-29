//
//  protocol.swift
//  JSONParser
//
//  Created by 김장수 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol JSONFormat: PrintableJSON {
    func typeName() -> String
    func typeTotal() -> Int
    func countsEachData() -> (int: Int, bool: Int, string: Int, array: Int, object: Int)
    
}

protocol PrintableJSON {
    func drawContents(with indent: Int) -> String
}
