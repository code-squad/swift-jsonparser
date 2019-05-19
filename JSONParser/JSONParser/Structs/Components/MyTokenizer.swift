//
//  MyTokenizer.swift
//  JSONParser
//
//  Created by 이동영 on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MyTokenizer: Tokenizer {
    
    var string: String =  ""
    
    var statuses = Stack<Analyzing>()
    
    public mutating func tokenize(_ string: String) throws -> [Token] {
        self.string = string
        try self.string.map{
            c in
            if(try self.isEnd(c)){
                try self.statuses.pop()
            }else{
                if(isStart(c)){
                    self.statuses.push(Analyzing.init(rawValue: c)!)
                }
            }
            print(c)
            self.statuses.show()
    
        }
        return []
    }
    
    public func isEnd(_ c: Character) throws -> Bool {
        if (statuses.size() > 0) {
        guard let current = try self.statuses.peek() as? Analyzing else { return false }
            return current.isEnd(c)
        }
        return false
        
    }
    
    public func isStart(_ c: Character) -> Bool {
        guard let a = Analyzing.init(rawValue: c) else { return false }
        return true
    }
    
    
}

