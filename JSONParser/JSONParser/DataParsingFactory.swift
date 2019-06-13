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
        let convertedData = convertJSONToDictionary(JSON: data)
        let (parsingData,canNotParsingData) = parsing(datas: convertedData)
        try canNotConvertDataPrint(data: canNotParsingData)
        return parsingData
    }
    
    private func convertJSONToDictionary(JSON:String) -> [String] {
        var ConvertedJSONData = JSON.trimmingCharacters(in: FormatItem.JSONObject)
        ConvertedJSONData = ConvertedJSONData.split(separator: FormatItem.blank).joined()
        return ConvertedJSONData.components(separatedBy: FormatItem.elementSperator)
    }
    
    private func parsing2(datas:[String])throws -> (JSONParse) {
        var ParsedData:[String:JSONValue] = [:]
        var countString = 0, countInt = 0, countBool = 0
        let datas = datas.map{$0.components(separatedBy: ":")}
        
        for data in datas {
            
            if isString(data: data) {
                let key = data[0].trimmingCharacters(in: FormatItem.DoubleQuotationMark)
                let value = String(data[1])
                ParsedData.updateValue(value, forKey: key)
                countString += 1
                continue
            }
            if isInt(data: data) {
                let key = data[0].trimmingCharacters(in: FormatItem.DoubleQuotationMark)
                let value = Int(data[1])!
                ParsedData.updateValue(value, forKey: key)
                countInt += 1
                continue
            }
            if isBool(data: data) {
                let key = data[0].trimmingCharacters(in: FormatItem.DoubleQuotationMark)
                let value = Bool(data[1])!
                ParsedData.updateValue(value, forKey: key)
                countBool += 1
                continue
            }
            
            throw ConvertError.canNotCovertData
            
        }
        return (JSONParse(ParsedData, countNumbers:(countString, countInt, countBool)))
    }
    
    private func isString(data:[String]) -> Bool {
        return DataTypeCriterion.String.isStrictSubset(of: CharacterSet(charactersIn: data[1]))
    }
    
    private func isInt(data:[String]) -> Bool {
        return CharacterSet(charactersIn: data[1]).isStrictSubset(of: DataTypeCriterion.Int)
    }
    
    private func isBool(data:[String]) -> Bool {
        return data[1] == DataTypeCriterion.Bool.true || data[1] == DataTypeCriterion.Bool.false
    }
    
    private func canNotConvertDataPrint(data:[String])throws {
        
        guard data.count == 0 else{
            throw ConvertError.canNotCovertData
        }
        
    }
}
