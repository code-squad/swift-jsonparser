//
//  MyJsonParser.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 21..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct MyJsonParser {
    
    func makeDictionary(_ input: [String]) -> [String:Any] {
        var data: [String:String] = [:]
        for index in 0..<input.count {
            if index % 2 == 0 {
                data[input[index]] = input[index+1]
            }
        }
        let castingData = typecasting(data)
        return castingData
    }
    
    func typecasting(_ input: [String:String]) -> [String:Any] {
        var castingData: [String:Any] = [:]
        for (key,value) in input {
            if let boolInput = Bool.init(value) {
                castingData[key] = Bool(boolInput)
            } else if let numberInput = Int.init(value) {
                castingData[key] = Int(numberInput)
            } else {
                castingData[key] = value
            }
        }
        return castingData
    }
    
}
