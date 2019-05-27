//
//  Utility.swift
//  JSONParser
//
//  Created by hw on 20/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Stack <T> {
    
    
    var stack : [T]
    init(){
        stack = [T]()
    }
    mutating func push(_ element : T){
        stack.append(element)
    }
    
    mutating func pop() -> T?{
        return stack.popLast()
    }
    mutating func peek() -> T?{
        return stack.last
    }
    
    func isEmpty() -> Bool {
        return stack.count == 0 
    }
    
   
}

struct Queue <T> {
    private var queue : [T]
    init(){
        queue = [T]()
    }
    var size: Int {
        get{
            return queue.count
        }
    }
    func isEmpty() -> Bool {
        return queue.count == 0
    }
    mutating func add(_ element : T){
        queue.append(element)
    }
    
    mutating func poll() -> T{
        return queue.removeFirst()
    }
    
    mutating func peek() -> T?{
        return queue.last
    }
    
    mutating func find(_ int : Int) -> T{
        if int < queue.count && int >= 0 {
            return queue[int]
        }
        return -1 as! T
    }
    
    func toArray() -> [T] {
        return self.queue
    }
}

extension Bool {
    static func &= (lhs: inout Bool, rhs: Bool) {
        lhs = lhs && rhs
    }
    static func |= (lhs: inout Bool, rhs: Bool ){
        lhs = lhs || rhs
    }
}

extension String {
    subscript (i : Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start ..< end])
    }
}
