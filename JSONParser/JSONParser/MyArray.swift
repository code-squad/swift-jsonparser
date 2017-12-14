//
//  MyArray.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct MyArray: ParsingTarget {
    var myArray : [String]
    
    init (_ stringValues: [String]) {
        myArray = stringValues
    }
    
    func count() -> Int {
        return myArray.count
    }
    
    func getEachValue(_ orderOfValue: Int) -> String {
        return myArray[orderOfValue]
    }

}
