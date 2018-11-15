//
//  SwiftObject.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 13..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct SwiftObject : Collection {
    private var swiftObject : [String:ObjectUsableType]
    private var numberByType : NumberByType
    
    init(_ object:[String:ObjectUsableType]) {
        self.swiftObject = object
        let values = Array<ObjectUsableType>(object.values)
        self.numberByType = values.numberByType()
    }
    
    func readObject() -> [String:ObjectUsableType] {
        return self.swiftObject
    }
    
    func readNumberOfElements() -> Int {
        return self.swiftObject.count
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
