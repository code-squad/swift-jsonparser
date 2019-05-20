//
//  Scanner.swift
//  JSONParser
//
//  Created by 이동영 on 21/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Scanner {
    var context: Analyzing
    var elements: [Character]
    var buffer = [Character]()
    var curser: Int = 0
    
    init(context: Analyzing, elements: [Character], curser:Int = 0 ){
        self.context = context
        self.elements = elements
    }
    
    func next() -> String {
        self.elements.map{
            isEnd($0)
        }
        return ""
    }
    
    func isEnd(_ c: Character) -> Bool {
        let currentCharactor = elements[curser]
        return self.context.isEnd(currentCharactor)
    }
    
    func hasNext() -> Bool {
        return self.curser > self.elements.count
    }
    
    mutating func nextCurser() {
        if(self.hasNext()){
            self.curser += 1
        }
    }
    
    mutating func nextCharacter() -> Character {
        self.nextCurser()
        return self.elements[self.curser]
    }
    
}
