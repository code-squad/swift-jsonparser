//
//  Validator.swift
//  JSONParser
//
//  Created by 이희찬 on 03/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

typealias CountNumbers = (intData:Int, boolData:Int, stringData:Int)

struct Counter {
    private let dataTypeCriterion = DataTypeCriterion()
    private var countInt = 0
    private var countBool = 0
    private var countString = 0
    private var countCanNotConvertData = 0
    private var canNotConvertData:[String] = []
    
    mutating func dataTypeCounter(convertedJSONToArray:[String])throws -> CountNumbers {
        
        for item in convertedJSONToArray {
            try stringDataCount(data: item)
        }
        return (intData : countInt, boolData:countBool, stringData:countString)
        
    }
    
    private mutating func stringDataCount(data:String)throws {
        
        guard dataTypeCriterion.distinguishingString.isStrictSubset(of: CharacterSet(charactersIn: data)) else{
            return try intDataCount(data: data)
        }
        countString += 1
        
    }
    
    private mutating func intDataCount(data:String)throws {
        
        guard CharacterSet(charactersIn: data).isStrictSubset(of: dataTypeCriterion.distinguishingInt) else{
            return try boolDataCount(data: data)
        }
        countInt += 1
        
    }
    
    private mutating func boolDataCount(data:String)throws {
        
        guard data == dataTypeCriterion.distinguishingBool.true || data == dataTypeCriterion.distinguishingBool.false else{
            canNotConvertData.append(data)
            countCanNotConvertData += 1
            return try canNotConvertDataPrint(countCanNotConvertData: countCanNotConvertData)
        }
        countBool += 1
        
    }
    
    private func canNotConvertDataPrint(countCanNotConvertData:Int)throws {
        
        guard countCanNotConvertData == 0 else{
            print(canNotConvertData)
            throw ConvertError.canNotCovertData
        }
        
    }
}
