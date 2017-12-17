//
//  MyArray.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct MyArray {
    let JSONFactory = JSONDataFactory()
    var myArray : String
    
    
    init (_ stringValues: String) {
        myArray = stringValues
    }
    
    func makeMyType() -> [String] {
       let targetArray = ParsingTargetFactory.setTargetToArray(myArray)
        return targetArray
    }
    
    
    func makeJSONDataValues () -> [JSONData] {
        let arrayInString = makeMyType()
        return JSONFactory.matchValueOfArray(arrayInString)
    }
    
}
