//
//  MyScanner.swift
//  JSONParser
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MyScanner: Scanner {
    let string: String
    var curser : Int = 0
    
    init(string: String){
        self.string = string
    }
    
    func hasNext() -> Bool {
        return true
    }
    
    mutating func next() throws -> Character {
        self.curser += 1
        let result = curser%2 == 0 ? "[" : "]"
        return result
    }
}
