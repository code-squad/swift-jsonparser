//
//  Stack.swift
//  JSONParser
//
//  Created by 이동영 on 18/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MyStack<T> {
    private var elements: Array<T>
    
    init() {
        self.elements = Array<T>()
    }
    
    func isEmpty() -> Bool {
        return self.elements.count > 0 ? false : true
    }
    
    mutating func push(_ e: T) {
        self.elements.append(e)
    }
    
    mutating func pop() -> T? {
        guard let lastElement = self.elements.popLast() else {
            return nil
        }
        return lastElement
    }
    
    func peek() -> T? {
        guard let lastElement = self.elements.last else {
            return nil
        }
        return lastElement
    }
    
    func size() -> Int {
        return self.elements.count
    }
    
    func show() {
        print(self.elements)
    }
    
    mutating func clear() {
        self.elements.removeAll()
    }
   
}

