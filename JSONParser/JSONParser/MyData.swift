//
//  MyData.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 4. 17..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct MyData {
    private var jsonData: [String:Any] = [:]
    private var array: [String] = []
    
    init(_ jsonData: [String:Any]) {
        self.jsonData = jsonData
    }
    
    init(_ dictionary: [String:Any], _ array: [String]) {
        self.jsonData = dictionary
        self.array = array
    }
    
    func resultObject() -> String {
        var data = "{"
        for (key, value) in self.jsonData {
            data += "\n \(key) : \(value),"
        }
        data.removeLast()
        data += "\n}"
        return data
    }
    
    func resultArray() -> String {
        var data = "["
        if !self.jsonData.isEmpty {
            data += "{"
            for (key, value) in self.jsonData {
                data += "\n \(key) : \(value),"
            }
            data.removeLast()
            data += "\n},\n"
        }
        if !self.array.isEmpty {
            data += "["
            for value in self.array{
                data += value + ","
            }
            data.removeLast()
            data += "],"
        }
        data.removeLast()
        data += "\n]"
        return data
    }
    
}
