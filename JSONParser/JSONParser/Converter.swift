//
//  Converter.swift
//  JSONParser
//
//  Created by 이희찬 on 03/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Converter {

    private let dataTypeCriterion = DataTypeCriterion()
    private var countCanNotConvertData = 0
    private var canNotConvertData:[String] = []
    
    static func convertToArray(JSON:String) -> [String] {
        
        let removedJSONArrayFormatInput = JSON.trimmingCharacters(in: FormatItem.JSONArrayFormat)
        let removedblankInput = removedJSONArrayFormatInput.split(separator: FormatItem.blank).joined()
        return removedblankInput.components(separatedBy: FormatItem.arraySperator)
        
    }
    
    mutating func makeParsingData(JSON:[String])throws -> JSONParse {
        
        var JSONParserData = JSONParse()
        var canNotParsingData =  CanNotParsingData()
        
        for element in JSON {
            
            if dataTypeCriterion.distinguishingString.isStrictSubset(of: CharacterSet(charactersIn: element)) {
                JSONParserData.parsedJSONValue.append(String(element))
                JSONParserData.countString += 1
                continue
            }
            
            if CharacterSet(charactersIn: element).isStrictSubset(of: dataTypeCriterion.distinguishingInt){
                JSONParserData.parsedJSONValue.append(Int(element)!)
                JSONParserData.countInt += 1
                continue
            }
            
            if element == dataTypeCriterion.distinguishingBool.true || element == dataTypeCriterion.distinguishingBool.false {
                JSONParserData.parsedJSONValue.append(Bool(element)!)
                JSONParserData.countBool += 1
                continue
            }
            canNotParsingData.canNotConvertData.append(element)
        }
        
        try canNotConvertDataPrint(data: canNotParsingData)
        
        return JSONParserData
        
    }
    
    private func canNotConvertDataPrint(data:CanNotParsingData)throws {
        
        guard data.count == 0 else{
            print(data.canNotConvertData)
            throw ConvertError.canNotCovertData
        }
        
    }
    
}



