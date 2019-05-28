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
    var curser : String.Index
    
    init(string: String){
        self.string = string
        self.curser = self.string.startIndex
    }
    
    func hasNext() -> Bool {
        return self.curser != self.string.endIndex
    }
    
    mutating func backCurser() {
        self.curser = self.string.index(before: self.curser)
    }
    
    mutating func moveCurser() {
        self.curser = self.string.index(after: self.curser)
    }
    
    mutating func next() -> Character? {
        guard self.hasNext() else { return nil }
        let character = self.string[self.curser]
        self.moveCurser()
        return character
    }
    
}
