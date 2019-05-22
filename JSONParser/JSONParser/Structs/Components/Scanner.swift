//
//  Scanner.swift
//  JSONParser
//
//  Created by 이동영 on 23/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Scanner {
    var nestedContexts: Stack<Context>
    var currentContext: Context { return try! nestedContexts.peek()}
    var buffer: Buffer<Character>
    var string: String
    var curser: Int = -1
    
    init(string: String ) {
        self.buffer = Buffer()
        self.string = string
        self.nestedContexts = Stack()
        self.nestedContexts.push(Context.Value)
    }
    
    mutating func next() -> String {
        self.fillBuffer()
        let string = String.init(self.buffer.readAll())
        self.clearBuffer()
        return string
    }
    
    mutating func enter(context:Context){
        self.nestedContexts.push(context)
    }
    
    mutating func exitContext() throws {
       _ = try self.nestedContexts.pop()
    }
  
    mutating func clearBuffer(){
        self.buffer.clear()
    }
    
    func fillBuffer(){
        
    }
    
    mutating func nextCurser(){
        self.curser += 1
    }
}
