//
//  SwiftArray.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct SwiftArray {
    private var swiftArr = [Any]()
    
    mutating func insertIntoArray(_ data:Any) {
        self.swiftArr.append(data)
    }
    
    func readArray() -> [Any] {
        return self.swiftArr
    }
    
    func readNumberOfArray() -> Int {
        return swiftArr.count
    }
    
    func readNumberOfString() -> Int {
        return swiftArr.numberOfStringForm()
    }
    
    func readNumberOfNumber() -> Int {
        return swiftArr.numberOfNumberForm()
    }
    
    func readNumberOfBool() -> Int {
        return swiftArr.numberOfBoolForm()
    }
}
