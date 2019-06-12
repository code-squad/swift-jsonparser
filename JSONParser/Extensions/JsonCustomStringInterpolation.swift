//
//  JsonCustomStringInterpolation.swift
//  JSONParser
//
//  Created by hw on 12/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

extension String.StringInterpolation {
    
    mutating func appendInterpolation(_ target: JsonParsable, count : Int ){
        if target is JsonObject {
            appendInterpolation(target as! JsonObject, count: count)
            return
        }
        if target is Array<JsonParsable>{
            appendInterpolation(target as! Array<JsonParsable>, count: count)
            return
        }
    }
    
    private func increaseTabSize(_ count: Int) -> String{
        var tab = ""
        for _ in 1..<count {
            tab += "\t"
        }
        return tab
    }
    
    mutating func appendInterpolation(_ array: Array<JsonParsable>, count : Int){
        var results = [String]()
        results.append("\(TokenSplitSign.squareBracketStart.description)")
        let elementList = composeArrayElement(array, count: count)
        if array[array.count-1] is JsonObject || array[array.count-1] is Array<JsonParsable> && count == 1 {
            results.append(elementList.joined(separator: ", "))
            results.append("\n\(TokenSplitSign.squareBracketEnd.description)")
        }else{
            results.append(elementList.joined(separator: ", "))
            results.append("\(TokenSplitSign.squareBracketEnd.description)")
        }
        appendLiteral(results.joined(separator: ""))
    }
    
    mutating func appendInterpolation(_ object: JsonObject, count: Int) {
        var results = [String]()
        let tab = increaseTabSize(count)
        let sortedKeyValueSet = object.keyValueSet.enumerated().sorted(by: { ( pair1, pair2) -> Bool in
            return pair1.element.key < pair2.element.key
        })
        results.append("\(TokenSplitSign.curlyBracketStart.description)")
        let elements = composeObjectElement(pairSet: sortedKeyValueSet, tab: tab, count: count )
        results.append(elements.joined(separator: ",\n"))
        results.append("\(tab)\(TokenSplitSign.curlyBracketEnd.description)")
        appendLiteral("\(results.joined(separator: "\n"))")
    }
    
    private func composeArrayElement(_ array: Array<JsonParsable>, count : Int) ->[String]{
        var elementList = [String]()
        for element in array {
            if element is JsonObject {
                elementList.append("\(element, count: count+1)")
                continue
            }
            if element is Array<JsonParsable>{
                if count == 1{
                    elementList.append("\n\t\(element, count: count+1)")
                }else {
                    elementList.append("\(element, count: count)")
                }
                continue
            }
            elementList.append(element.description)
        }
        return elementList
    }
    
    private func composeObjectElement(pairSet sortedKeyValueSet: SortedKeyValueSet, tab: String, count: Int) -> [String] {
        var elements = [String]()
        for sortedPair in sortedKeyValueSet {
            if sortedPair.element.value is JsonObject{
                elements.append("\(tab)\t\(sortedPair.element.key) : \(sortedPair.element.value as! JsonObject, count: count+1)")
                continue
            }
            if sortedPair.element.value is Array<JsonParsable>{
                elements.append("\(tab)\t\(sortedPair.element.key) : \(sortedPair.element.value as! Array<JsonParsable>, count: 1)")
                continue
            }
            elements.append("\(tab)\t\(sortedPair.element.key) : \(sortedPair.element.value)")
        }
        return elements
    }
    
}
