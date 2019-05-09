//
//  JsonDictionary.swift
//  JSONParser
//
//  Created by hw on 09/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonDictionary {
    private var jsonElements : [LexicalType : [String]] = [LexicalType.intNumber : [String](), LexicalType.bool :  [String](), LexicalType.string : [String]()]
    
    var jsonFormmatList : String {
        get{
            return "[ Int : \(jsonIntElementList), String : \(jsonStringElementList), Bool : \(jsonBoolElementList) ]"
        }
    }
    
    private var jsonIntElementList : String {
        get {
            var result = ""
            guard let elementList = jsonElements[LexicalType.intNumber] else {
                return result
            }
           
            result = printElementList (elementList)
            return result
        }
    }
    
    private var jsonStringElementList : String {
        get {
            var result = ""
            guard let elementList = jsonElements[LexicalType.string] else {
                return result
            }
            result = printElementList (elementList)
            return result
        }
    }
    
    private func printElementList (_ list : [String ]) ->  String {
        var result = "[ "
        for index in 0..<list.count-1 {
            result += "\(list[index]), "
        }
        result += "\(list[list.count-1]) ]"
        return result
    }
    
    private var jsonBoolElementList : String {
        get {
            var result = ""
            guard let elementList = jsonElements[LexicalType.bool] else {
                return result
            }
            result = printElementList (elementList)
            return result
        }
    }
    
    init (lexPair : [LexPair]){
        for element in lexPair{
            self.jsonElements[element.type]?.append(element.content)
        }
    }
    var intCount : Int {
        get {
            return jsonElements[LexicalType.intNumber]?.count ?? 0
        }
    }
    var stringCount : Int {
        get {
            return jsonElements[LexicalType.string]?.count ?? 0
        }
    }
    var boolCount : Int {
        get{
            return jsonElements[LexicalType.bool]?.count ?? 0
        }
    }
    var totalCount : Int {
        get {
            return boolCount + stringCount + intCount
        }
    }
}
    
