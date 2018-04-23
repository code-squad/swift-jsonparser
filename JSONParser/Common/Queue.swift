//
//  Queue.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 19..
//  Copyright © 2018년 JK. All rights reserved.
//

class Queue<T> {
    private var queue:[T]
    
    init(_ queueFormat: [T]){
        self.queue = queueFormat
    }
    init() {
        self.queue = [T]()
    }
    
    func enqueue(_ value: T) {
        self.queue.append(value)
    }
    
    func dequeue() -> T? {
        return isEmpty() ? nil : self.queue.remove(at: 0)
    }
    
    func front() -> T? {
        return isEmpty() ? nil : self.queue[0]
    }
    
    func isEmpty() -> Bool {
        return queue.count == 0
    }
    
}
