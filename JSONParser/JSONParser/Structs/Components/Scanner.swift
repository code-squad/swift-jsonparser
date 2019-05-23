//
//  Scanner.swift
//  JSONParser
//
//  Created by 이동영 on 23/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Scanner {
    private var nestedContexts: Stack<Context>
    private var currentContext: Context { return try! nestedContexts.peek()}
    private var buffer: Buffer<Character>
    private var charaters: [Character]
    private var curser: Int = -1
    
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
    
    private mutating func enter(context: Context) {
        if !self.currentContext.canInclude(context: context){ return }
        self.nestedContexts.push(context)
    }
    
    private mutating func exitContext() throws {
        _ = try self.nestedContexts.pop()
    }
    
    private mutating func clearBuffer(){
        self.buffer.clear()
    }
    
    private mutating func fillBuffer() throws {
        while(self.hasNext()){
            let c = nextChar()
            if(try !self.needContinue(c: c)){ return }
            self.buffer.write(e: c)
        }
    }
    
    private mutating func needContinue(c: Character) throws -> Bool {
        if let context = Context.init(rawValue: c){
            if(try isEnd(context: context, c: c)){
                return false
            }
        }
        else if(self.currentContext.isFinish(inCaseOf: c)){
            self.buffer.write(e: c)
            try self.exitContext()
            return false
        }
        return true
    }

    private mutating func isEnd (context:Context,c:Character) throws -> Bool {
        if(self.currentContext.canInclude(context: context)){
            if enterStringContext(context: context, c: c){ return true }
        }
        else if(self.currentContext.isFinish(inCaseOf: c)) {
            let beforeContext = self.currentContext
            if try exitStringContext(beforeContext: beforeContext,char:c) { return true }
            try self.exitContext()
        }
        return false
    }
    
    private mutating func exitStringContext(beforeContext:Context,char:Character) throws -> Bool {
        if beforeContext != .String {
            self.buffer.write(e: char)
            try self.exitContext()
            return true
        }
        return false
    }
    
    private mutating func enterStringContext(context:Context,c:Character) -> Bool {
        self.enter(context: context)
        if currentContext == .Array {
            self.buffer.write(e: c)
            return true
        }
        return false
    }
    
    private mutating func nextCurser() {
        self.curser += 1
    }
    
    func hasNext() -> Bool {
        return self.curser < self.charaters.count-1
    }
    
    private mutating func nextChar() -> Character {
        self.nextCurser()
        return self.charaters[self.curser]
    }
    
    private enum Exception: String, Error, CustomStringConvertible {
        var description: String {return self.rawValue}
        
        case EOL = "END OF LINE"
    }
}
