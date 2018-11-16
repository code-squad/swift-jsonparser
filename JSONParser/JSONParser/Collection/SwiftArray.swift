//
//  SwiftArray.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct SwiftArray : SwiftType {
    private var swiftArray : [ArrayUsableType]
    private var numberByType : NumberByType

    init(_ array:[ArrayUsableType]) {
        self.swiftArray = array
        self.numberByType = array.numberByType()
    }
    
    func readArray() -> [ArrayUsableType] {
        return self.swiftArray
    }
    
    func readNumberOfElements() -> Int {
        return swiftArray.count
    }
    
    func readNumberOfString() -> Int {
        return numberByType.numberOfString()
    }
    
    func readNumberOfNumber() -> Int {
        return numberByType.numberOfNumber()
    }
    
    func readNumberOfBool() -> Int {
        return numberByType.numberOfBool()
    }
    func readNumberOfObject() -> Int {
        return numberByType.numberOfObject()
    }
}

