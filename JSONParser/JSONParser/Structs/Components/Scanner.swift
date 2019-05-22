//
//  Scanner.swift
//  JSONParser
//
//  Created by 이동영 on 21/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Scanner{
    var currentContext: Context
    var nestedContexts =  Stack<Context>()
    private let characters: [Character]
    private var buffer = [Character]()
    private var curser: Int = -1
    
    init(context: Context, string: String) {
        self.nestedContexts.push(context)
        self.currentContext = context
        self.characters = string.map{ $0 }
    }
    
    mutating func next() throws -> String {
        try  self.buffering()
        let nextString = String.init(self.buffer)
        self.clearBuffer()
        
        return nextString
    }
    
    mutating func buffering() throws {
        var c: Character = nextChar()
        self.enterContext(c)
        self.write(c)
        if(c == Symbols.openBracket ){
            self.nestedContexts.push(.Value)
            self.nextCurser()
            return
             print(self.nestedContexts)
        }
        while needContinue(c){
            c = nextChar()
            self.write(c)
        }
        try self.exitContext()
    }
    
    func needContinue(_ c: Character ) -> Bool {
        if(self.currentContext == .String) && (self.buffer.count < 3) { return true }
        return !self.currentContext.isStart(c) && !self.currentContext.isEnd(c)
    }
    
    mutating func enterContext(_ c: Character){
        guard let newContext = Context.init(rawValue: c) else { return }
        self.currentContext = newContext
        self.nestedContexts.push(newContext)
        print("\(newContext)컨텍스트 접속" )
    }
    
    mutating func exitContext() throws {
        print("\(try self.nestedContexts.peek())컨텍스트 이웃" )
        _ = try self.nestedContexts.pop()
        self.currentContext = try self.nestedContexts.peek()
        
    }
    
    mutating func clearBuffer(){
        self.buffer.removeAll()
    }
    
    private mutating func write(_ c: Character){
        self.buffer.append(c)
    }
    
    func hasNext() -> Bool {
        return self.characters.count > self.curser
    }
    
    private mutating func nextCurser(){
        self.curser = self.hasNext() ? self.curser + 1 : self.curser
    }
    
    private mutating func nextChar() -> Character {
        self.nextCurser()
        return self.characters[self.curser]
    }
    
}

