//
//  Validator.swift
//  JSONParser
//
//  Created by 이희찬 on 03/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

typealias CountNumbers = (string:Int, int:Int, bool: Int)

struct Parser {
    
    mutating func makeParsingData(input:String)throws -> Countable {
        
        if checkFormat(of: input, is: Array()) {
            if checkFormat(of: input, is: Object()) {
                let (parsedData,numbers) = try parsingObject(input: input)
                return JSONObject(parsingData: parsedData, Numbers: numbers)
            }
            throw InputError.formatError
        }
        if iscontainObject(at: input) {
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
        let canParseDataArray = converter(data: input, to: Array())
        var ParsedData:[JSONValue] = []
        var countString = 0, countInt = 0, countBool = 0
        
        for element in canParseDataArray {
            
            guard !element.isEmpty else{ continue }
            
            if element.isString() {
                ParsedData.append(String(element))
                countString += 1
                continue
            }
            if element.isInt() {
                ParsedData.append(Int(element)!)
                countInt += 1
                continue
            }
            if element.isBool() {
                ParsedData.append(Bool(element)!)
                countBool += 1
                continue
            }
            
            throw InputError.formatError
            
        }
        return (ParsedData,(countString, countInt, countBool))
    }
    
    private func converter(data:String,to formatItem: HasFormatItem) -> [String] {
        var data = data.trimmingCharacters(in: formatItem.container)
        data = data.split(separator: formatItem.blank).joined()
        return data.components(separatedBy: formatItem.elementSeparator)
    }
    
    private func parsingObject(input:String)throws -> ([String:JSONValue],CountNumbers) {
        let canParseDataArray = converter(data: input, to:Object()).map{$0.components(separatedBy: ":")}
        var ParsedData:[String:JSONValue] = [:]
        var countString = 0, countInt = 0, countBool = 0
        
        for element in canParseDataArray {
            
            guard element[0].isString() else{
                throw InputError.formatError
            }
            let key = element[0].trimmingCharacters(in: TypeCriterion.String)
            
            if element[1].isString() {
                let value = element[1].trimmingCharacters(in: TypeCriterion.String)
                ParsedData.updateValue(value, forKey: key)
                countString += 1
                continue
            }
            if element[1].isInt() {
                let value = Int(element[1])!
                ParsedData.updateValue(value, forKey: key)
                countInt += 1
                continue
            }
            if element[1].isBool() {
                let value = Bool(element[1])!
                ParsedData.updateValue(value, forKey: key)
                countBool += 1
                continue
            }
            
            throw ConvertError.canNotCovertData
            
        }
        return (ParsedData, (countString, countInt, countBool))
    }
    
    private func convertArrayContainObject(input: String)throws -> ([String], String) {
        let arrayFormat = Array(), objectFormat = Object()
        let data = input.trimmingCharacters(in: arrayFormat.container)
        let (objects, arraydata) = slice(data: data, to: objectFormat)
        return (objects, arraydata)
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

    
}
