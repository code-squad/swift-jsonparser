//
//   FirstObjectProtocol.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

protocol FirstClassObject {
    func countParsingData() -> DataInfo
    func printParsingData(intent: Int) -> String
     
}

extension Dictionary: FirstClassObject {
    func countParsingData() -> DataInfo {
        var dataInfo = DataInfo()
        for data in self {
            if data.value is Int {
                dataInfo.increamenInt()
            }else if data.value is String {
                dataInfo.increamentString()
            }else if data.value is Bool {
                dataInfo.increamentBool()
            }else if data.value is Dictionary<String, Any> {
                dataInfo.increamentDictionary()
            }else if data.value is Array<Any> {
                dataInfo.increamentArray()
            }
        }
        return dataInfo
    }
    
    func printParsingData(intent : Int) -> String {
        var result = ""
        var count = 0
        result.append("{\n")
        for data in self {
            count += 1
            result.append(String.init(repeating: "\t" as Character, count: intent))
            result.append(String(describing: data.key))
            result.append(" : ")
            if data.value is Array<Any> {
                let resultOfArray = (data.value as! FirstClassObject).printParsingData(intent: intent+1)
                result.append(resultOfArray)
            }else if data.value is Dictionary<String, Any> {
                let resultOfDictionary = (data.value as! FirstClassObject).printParsingData(intent: intent+1)
                result.append(resultOfDictionary)
            }else {
                result.append(String(describing: data.value))
            }
            if self.count == count {
                result.append("\n")
                result.append(String.init(repeating: "\t" as Character, count: intent))
                result.append("}")
            }else {
                result.append(",\n")
            }
        }
        return result
    }
}

extension Array: FirstClassObject {
    func countParsingData() -> DataInfo {
        var dataInfo = DataInfo()
        for data in self {
            if data is Int {
                dataInfo.increamenInt()
            }else if data is String {
                dataInfo.increamentString()
            }else if data is Bool {
                dataInfo.increamentBool()
            }else if data is Dictionary<String, Any> {
                dataInfo.increamentDictionary()
            }else if data is Array<Any> {
                dataInfo.increamentArray()
            }
        }
        return dataInfo
    }
    
    func printParsingData(intent: Int) -> String {
        var result = ""
        var countOfData = 0
        result.append("[")
        for data in self {
            countOfData += 1
            if data is Dictionary<String, Any> {
                let resultOfDictionary = (data as! FirstClassObject).printParsingData(intent: intent+1)
                result.append(resultOfDictionary)
            }else if data is Array<Any> {
                result.append("\t")
                let resultOfArray = (data as! FirstClassObject).printParsingData(intent: intent+1)
                result.append(resultOfArray)
            }else {
                result.append(String(describing: data))
            }
            if self.count == countOfData {
                if intent > 0 {
                    result.append("]")
                }else {
                    result.append("\n]")
                }
            }else {
                if intent > 0 {
                    result.append(", ")
                }else {
                    result.append(",\n")
                }
            }
        }
        return result
    }
}

