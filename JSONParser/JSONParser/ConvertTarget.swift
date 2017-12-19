//
//  ConvertTarget.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 18..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

protocol ConvertTarget{
    func matchType(_ target: ConvertTarget) -> JSONData
}

extension Array: ConvertTarget {
    func matchType(_ target: ConvertTarget) -> JSONData {
        let dataConverter = DataTypeConverter()
        var parsedJSONArray : [JSONData] = []
        parsedJSONArray = dataConverter.makeConvertedArray(target as! [String])
        return JSONData.ArrayValue(parsedJSONArray)
    }
}

extension Dictionary: ConvertTarget {
    func matchType(_ target: ConvertTarget) -> JSONData {
        let dataConverter = DataTypeConverter()
        var parsedJSONObject : Dictionary<String, JSONData> = [:]
        parsedJSONObject = dataConverter.makeConvertedObject(target as! [String:String])
        return JSONData.ObjectValue(parsedJSONObject)
    }
}
