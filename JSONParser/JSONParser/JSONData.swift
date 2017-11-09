//
//  JSONData.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONData {
    typealias Number = Int
    enum DataType {
        case array
        case object
    }
    private(set) var type: DataType
    private(set) var string: [String:String] = [:]
    private(set) var number: [String:Number] = [:]
    private(set) var bool: [String:Bool] = [:]
    var count: Int {
        return self.number.count + self.string.count + self.bool.count
    }
    
    init(_ data: [String:Any], ofType type: DataType) {
        self.type = type
        for (key, value) in data {
            switch value {
            case is String: self.string.updateValue(value as! String, forKey: key)
            case is Number: self.number.updateValue(value as! Number, forKey: key)
            case is Bool: self.bool.updateValue(value as! Bool, forKey: key)
            default: return
            }
        }
    }
    
}

