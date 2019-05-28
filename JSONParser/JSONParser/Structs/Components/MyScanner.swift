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
    
    mutating func next() throws -> Character {
        guard self.hasNext() else { throw Error.EOL }
        let character = self.string[self.curser]
            self.nextCurser()
        return character
    }
    
    private mutating func nextCurser() {
        self.curser = self.string.index(after: self.curser)
    }
    
    enum Error: String, Swift.Error {
        case EOL = "END OF LINE"
    }
}
