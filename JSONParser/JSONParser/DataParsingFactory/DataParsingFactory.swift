//
//  Validator.swift
//  JSONParser
//
//  Created by 이희찬 on 03/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

typealias CountNumbers = (string:Int, int:Int, bool: Int)

struct DataParsingFactory {
    
    mutating func makeParsingData(input:String)throws -> countable {
        
        guard checkFormat(of: input, is: Array()) else{
            guard checkFormat(of: input, is: Object()) else{
                throw InputError.formatError
            }
            let (parsedData,numbers) = try parsingObject(input: input)
            return JSONObject(parsingData: parsedData, Numbers: numbers)
        }
        
        guard iscontainObject(at: input) else{
            let (parsedData,numbers) = try parsingArray(input: input)
            return JSONArray(parsingData: parsedData, Numbers: numbers)
        }
        
        let (objectdatas, arraydata) = try convertArrayContainObject(input: input)
        let parsedObjects = try objectdatas.map{try parsingObject(input: $0)}
        let JSONObjects = parsedObjects.map{JSONObject(parsingData: $0.0, Numbers: $0.1)}
        let (arrayDatas, numbers) = try parsingArray(input: arraydata)
        return JSONArray(parsingData: JSONObjects + arrayDatas, Numbers: numbers, objectNumber: parsedObjects.count)
        
    }
    
    private func checkFormat(of input:String, is formatItem:HasFormatItem) -> Bool {
        let opener = String(formatItem.containerOpen), closer = String(formatItem.containerClose)
        return input.hasPrefix(opener) && input.hasSuffix(closer)
    }
    
    private func iscontainObject(at input:String) -> Bool {
        let formatItem = Object()
        return formatItem.container.isStrictSubset(of: CharacterSet(charactersIn: input))
    }
    
    private func parsingArray(input:String)throws -> ([JSONValue], CountNumbers) {
        let datas = converter(data: input, to: Array())
        var ParsedDatas:[JSONValue] = []
        var countString = 0, countInt = 0, countBool = 0
        
        for data in datas {
            
            guard !data.isEmpty else{ continue }
            
            if isString(data: data) {
                ParsedDatas.append(String(data))
                countString += 1
                continue
            }
            if isInt(data: data) {
                ParsedDatas.append(Int(data)!)
                countInt += 1
                continue
            }
            if isBool(data: data) {
                ParsedDatas.append(Bool(data)!)
                countBool += 1
                continue
            }
            
            throw InputError.formatError
            
        }
        return (ParsedDatas,(countString, countInt, countBool))
    }
    
    private func converter(data:String,to formatItem: HasFormatItem) -> [String] {
        var data = data.trimmingCharacters(in: formatItem.container)
        data = data.split(separator: formatItem.blank).joined()
        return data.components(separatedBy: formatItem.elementSperator)
    }
    
    private func parsingObject(input:String)throws -> ([String:JSONValue],CountNumbers) {
        let datas = converter(data: input, to:Object()).map{$0.components(separatedBy: ":")}
        var ParsedDatas:[String:JSONValue] = [:]
        var countString = 0, countInt = 0, countBool = 0
        
        for data in datas {
            
            guard isString(data: data[0]) else{
                throw InputError.formatError
            }
            let key = data[0].trimmingCharacters(in: TypeCriterion.String)
            
            if isString(data: data[1]) {
                let value = data[1].trimmingCharacters(in: TypeCriterion.String)
                ParsedDatas.updateValue(value, forKey: key)
                countString += 1
                continue
            }
            if isInt(data: data[1]) {
                let value = Int(data[1])!
                ParsedDatas.updateValue(value, forKey: key)
                countInt += 1
                continue
            }
            if isBool(data: data[1]) {
                let value = Bool(data[1])!
                ParsedDatas.updateValue(value, forKey: key)
                countBool += 1
                continue
            }
            
            throw ConvertError.canNotCovertData
            
        }
        return (ParsedDatas, (countString, countInt, countBool))
    }
    
    private func convertArrayContainObject(input: String)throws -> ([String], String) {
        let arrayFormat = Array(), objectFormat = Object()
        let data = input.trimmingCharacters(in: arrayFormat.container)
        let (objectdatas, arraydata) = slice(data: data, to: objectFormat)
        return (objectdatas, arraydata)
    }
    
    func slice(data: String, to formatItem: HasFormatItem) -> ([String],String) {
        var characters = data.map{$0}
        var openIndex = 0
        var container = false
        var object:[String] = [], arrayData:[Character] = []
        for i in 0..<characters.count {
            if container == true {
                if characters[i] == formatItem.containerClose {
                    container.toggle()
                    object.append(String(characters[openIndex...i]))
                }
                continue
            }
            if characters[i] == formatItem.containerOpen{
                container.toggle()
                openIndex = i
                continue
            }
            arrayData.append(characters[i])
        }
        return (object, String(arrayData))
    }
    
    private func isString(data:String) -> Bool {
        return TypeCriterion.String.isStrictSubset(of: CharacterSet(charactersIn: data))
    }
    
    private func isInt(data:String) -> Bool {
        return CharacterSet(charactersIn: data).isStrictSubset(of: TypeCriterion.Int)
    }
    
    private func isBool(data:String) -> Bool {
        return data == TypeCriterion.Bool.true || data == TypeCriterion.Bool.false
    }
    
}
