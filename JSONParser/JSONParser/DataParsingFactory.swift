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
    
    mutating func makeParsingData(data:String)throws -> JSONParse {
        let convertedData = convertJSONToArray(JSON: data)
        let (parsingData,canNotParsingData) = parsing(datas: convertedData)
        try canNotConvertDataPrint(data: canNotParsingData)
        return parsingData
    }
    
    private func convertJSONToArray(JSON:String) -> [String] {
        var ConvertedJSONData = JSON.trimmingCharacters(in: FormatItem.JSONArray)
        ConvertedJSONData = ConvertedJSONData.split(separator: FormatItem.blank).joined()
        return ConvertedJSONData.components(separatedBy: FormatItem.arraySperator)
    }
    
    private func parsing(datas:[String]) -> (JSONParse, [String]) {
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
        return (JSONParse(ParsedData, countNumbers:(countString, countInt, countBool)), canNotParsingData)
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
    
    private func canNotConvertDataPrint(data:[String])throws {
        
        guard data.count == 0 else{
            throw ConvertError.canNotCovertData
        }
        
    }
}
