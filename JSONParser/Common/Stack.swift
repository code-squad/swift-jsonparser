//
//  Stack.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 19..
//  Copyright © 2018년 JK. All rights reserved.
//

class Stack<T> {
    
    private var stack: [T]
    
    init() {
        self.stack = [T]()
    }
    
    init(_ stackForamt: [T]) {
        self.stack = stackForamt
    }
    
    func push(_ value : T) {
        self.stack.append(value)
    }
    
    func pop() -> T? {
        return (!empty() ? self.stack.removeLast() : nil)
    }
    
    func peek() -> T? {
        return (!empty() ? self.stack[self.stack.count - 1] : nil) 
    }
    
    func empty() -> Bool {
        return stack.count == 0
    }
}
