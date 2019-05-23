//
//  Scanner2.swift
//  JSONParser
//
//  Created by 이동영 on 23/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Scanner {
    var nestedContexts = Stack<Context2>()
    var currentContext: Context2  { return try! nestedContexts.peek()}
    var buffer: Buffer<Character> = Buffer()
    var string: String
    
    init(){
        
    }
    
    func next() -> String {
        return ""
    }
    
    mutating func enter(context: Context2){
        self.nestedContexts.push(context)
    }
    
    mutating func exit(context: Context2) throws {
        try self.nestedContexts.pop()
    }
    
    
    
    
}
