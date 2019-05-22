//
//  Buffer.swift
//  JSONParser
//
//  Created by 이동영 on 21/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Buffer<T> {
    var elements = [T]()
    
    func size() -> Int {
        return self.elements.count
    }
    
    mutating func write(e:T){
        self.elements.append(e)
    }
    
    func read(at:Int) -> T {
        return self.elements[at]
    }
    
    func readAll() -> [T] {
        return self.elements
    }
    
    mutating func clear(){
        self.elements.removeAll()
    }

}
