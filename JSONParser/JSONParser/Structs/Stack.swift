//
//  Stack.swift
//  JSONParser
//
//  Created by 이동영 on 18/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Stack<T>{
    private var elements:[T]
    
    init(){
        self.elements = [T]()
    }
    
    func isEmpty() -> Bool {
        return elements.count > 0 ? false : true
    }
    
    mutating func push(_ e:T){
        self.elements.append(e)
    }
    
    mutating func pop() throws -> T {
        guard let lastElement = self.elements.popLast() else {
            throw Exception.Empty
        }
        
        return lastElement
    }
    
    func peek() throws -> T {
        guard let lastElement = self.elements.last else {
            throw Exception.Empty
        }
        return lastElement
    }
    
    func size() -> Int {
        return self.elements.count
    }
    
    func show(){
        print(self.elements)
    }
    
    mutating func clear(){
        self.elements.removeAll()
    }
    
    enum Exception: String,Error,CustomStringConvertible{
        var description: String { return self.rawValue}
        
        case Empty = "스택이 비었습니다."
    }
}

