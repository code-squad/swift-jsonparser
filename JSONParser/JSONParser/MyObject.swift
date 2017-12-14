//
//  MyObject.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct MyObject: ParsingTarget {
    var myObject: Dictionary<String, String>
    
    init (_ stringValues: Dictionary<String, String>) {
        myObject = stringValues
    }
    
    func count () -> Int {
        return myObject.count
    }

    func getEachValue(_ orderOfvalue: Int) -> String {
        let objectValues = Array(myObject.values)
        return objectValues[orderOfvalue]
    }
}
    
    
extension MyObject {
    func getDictionary() -> Dictionary<String, String> {
        return self.myObject
    }
    
}
