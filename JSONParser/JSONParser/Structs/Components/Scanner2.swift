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
        if string.count == 0 { throw Exception.EOL }
        return string
    }
    
    private mutating func enter(context: Context) {
        guard self.currentContext.canInclude(context: context) else { return }
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
            let character = nextCharacter()
            if(try !self.needContinue(character: character)){ return }
            self.buffer.write(element: character)
        }
    }
    
    private mutating func needContinue(character: Character) throws -> Bool {
        if let context = Context.init(rawValue: character){
            if(try isEnd(context: context, character: character)){
                return false
            }
        }
        else if(self.currentContext.isFinish(inCaseOf: character)){
            self.buffer.write(element: character)
            try self.exitContext()
            return false
        }
        return true
    }

    private mutating func isEnd (context:Context, character:Character) throws -> Bool {
        if(self.currentContext.canInclude(context: context)){
            if enterStringContext(context: context, character: character){ return true }
        }
        else if(self.currentContext.isFinish(inCaseOf: character)) {
            let beforeContext = self.currentContext
            if try exitStringContext(beforeContext: beforeContext,character:character) { return true }
            try self.exitContext()
        }
        return false
    }
    
    private mutating func exitStringContext(beforeContext:Context, character:Character) throws -> Bool {
        if beforeContext != .String {
            self.buffer.write(element: character)
            try self.exitContext()
            return true
        }
        return false
    }
    
    private mutating func enterStringContext(context:Context, character:Character) -> Bool {
        self.enter(context: context)
        if currentContext == .Array {
            self.buffer.write(element: character)
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
    
    private mutating func nextCharacter() -> Character {
        self.nextCurser()
        return self.charaters[self.curser]
    }
    
    private enum Exception: String, Error, CustomStringConvertible {
        var description: String {return self.rawValue}
        
        case EOL = "END OF LINE"
    }
}
