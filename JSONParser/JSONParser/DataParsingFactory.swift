//
//  Validator.swift
//  JSONParser
//
//  Created by 이희찬 on 03/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

typealias countNumbers = (string:Int, int:Int, bool: Int)

struct DataParsingFactory {
    
    mutating func makeParsingData(data:[String])throws -> JSONParse {
        let (parsingData,canNotParsingData) = parsing(datas: data)
        try canNotConvertDataPrint(data: canNotParsingData)
        return parsingData
    }
    
    private func parsing(datas:[String]) -> (JSONParse,CanNotParsingData) {
        var ParsedData:[JSONValue] = []
        var canNotParsingData:[String] = []
        var countString = 0, countInt = 0, countBool = 0
        
        for data in datas {
            
            if isString(data: data) {
                ParsedData.append(String(data))
                countString += 1
                continue
            }
            if isInt(data: data) {
                ParsedData.append(Int(data)!)
                countInt += 1
                continue
            }
            if isBool(data: data) {
                ParsedData.append(Bool(data)!)
                countBool += 1
                continue
            }
            
            canNotParsingData.append(data)
            
        }
        return (JSONParse(ParsedData, countNumbers:(countString, countInt, countBool)), CanNotParsingData(canNotParsingData))
    }
    
    private func isString(data:String) -> Bool {
        return DataTypeCriterion.String.isStrictSubset(of: CharacterSet(charactersIn: data))
    }
    
    private func isInt(data:String) -> Bool {
        return CharacterSet(charactersIn: data).isStrictSubset(of: DataTypeCriterion.Int)
    }
    
    private func isBool(data:String) -> Bool {
        return data == DataTypeCriterion.Bool.true || data == DataTypeCriterion.Bool.false
    }
    
    private func canNotConvertDataPrint(data:CanNotParsingData)throws {
        
        guard data.count == 0 else{
            print(data.canNotParsingData)
            throw ConvertError.canNotCovertData
        }
        
    }
}
