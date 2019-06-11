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
        let dataTypeCriterion = DataTypeCriterion()
        
        var ParsedData:[JSONValue] = []
        var canNotParsingData:[String] = []
        var countString = 0, countInt = 0, countBool = 0
        
        for element in datas {
            
            if dataTypeCriterion.distinguishingString.isStrictSubset(of: CharacterSet(charactersIn: element)) {
                ParsedData.append(String(element))
                countString += 1
                continue
            }
            if CharacterSet(charactersIn: element).isStrictSubset(of: dataTypeCriterion.distinguishingInt){
                ParsedData.append(Int(element)!)
                countInt += 1
                continue
            }
            if element == dataTypeCriterion.distinguishingBool.true || element == dataTypeCriterion.distinguishingBool.false {
                ParsedData.append(Bool(element)!)
                countBool += 1
                continue
            }
            
            canNotParsingData.append(element)
            
        }
        
        return (JSONParse(ParsedData, countNumber:(countString, countInt, countBool)), CanNotParsingData(canNotParsingData))
        
    }
    
    private func canNotConvertDataPrint(data:CanNotParsingData)throws {
        
        guard data.count == 0 else{
            print(data.canNotParsingData)
            throw ConvertError.canNotCovertData
        }
        
    }
}
