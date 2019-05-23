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
    var charaters: [Character]
    var curser: Int = -1
    
    init(string: String ) {
        self.buffer = Buffer()
        self.charaters = string.map{ $0 }
        self.nestedContexts = Stack()
        self.nestedContexts.push(Context.Value)
    }
    
    mutating func next() throws -> String {
        try self.fillBuffer()
        let string = String.init(self.buffer.readAll())
        self.clearBuffer()
        if string.count == 0 { throw Exception.EOL}
        return string
    }
    
    mutating func enter(context: Context){
        if !self.currentContext.canInclude(context: context){ return }
        self.nestedContexts.push(context)
    }
    
    mutating func exitContext() throws {
        _ = try self.nestedContexts.pop()
    }
    
    mutating func clearBuffer(){
        self.buffer.clear()
    }
    
    mutating func fillBuffer() throws {
        while(self.hasNext()){
            let c = nextChar()
            if let context = Context.init(rawValue: c){
                if(self.currentContext.canInclude(context: context)){
                    self.enter(context: context)
                    if currentContext == .Array {
                        self.buffer.write(e: c)
                        return
                    }
                }else if(self.currentContext.isFinish(inCaseOf: c)){
                    let beforeContext = self.currentContext
                    if beforeContext != .String {
                        self.buffer.write(e: c)
                        try self.exitContext()
                        return
                    }
                    try self.exitContext()
                }
            }
            else if(self.currentContext.isFinish(inCaseOf: c)){
                self.buffer.write(e: c)
                try self.exitContext()
                return
            }
            self.buffer.write(e: c)
        }
        
    }
    
    mutating func nextCurser(){
        self.curser += 1
    }
    
    func hasNext() -> Bool {
        return self.curser < self.charaters.count-1
    }
    
    mutating func nextChar() -> Character {
        self.nextCurser()
        return self.charaters[self.curser]
    }
    
    enum Exception: String, Error, CustomStringConvertible {
        var description: String {return self.rawValue}
        
        case EOL = "END OF LINE"
    }
}
