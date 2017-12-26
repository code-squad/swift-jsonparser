//
//  ConvertTarget.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 18..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

protocol ConvertTarget{
    func matchType(_ target: ConvertTarget) throws -> JSONData
}

extension Array: ConvertTarget {
    func matchType(_ target: ConvertTarget) throws -> JSONData {
        let dataConverter = DataTypeConverter()
        var parsedJSONArray : [JSONData] = []
        do {
           parsedJSONArray = try dataConverter.makeConvertedArray(target as! [String])
        } catch let error{
            throw error
        }
        return JSONData.ArrayValue(parsedJSONArray)
    }
}

extension Dictionary: ConvertTarget {
    func matchType(_ target: ConvertTarget) throws -> JSONData {
        let dataConverter = DataTypeConverter()
        var parsedJSONObject : Dictionary<String, JSONData> = [:]
        do {
            parsedJSONObject = try dataConverter.makeConvertedObject(target as! [String:String])
        } catch let error {
            throw error
        }
        return JSONData.ObjectValue(parsedJSONObject)
    }
}
