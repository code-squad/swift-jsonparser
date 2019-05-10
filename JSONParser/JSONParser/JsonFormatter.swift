//
//  JsonFormatter.swift
//  JSONParser
//
//  Created by hw on 10/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonFormatter{
    
    private var jsonDictionary: JsonDictionary
    
    init(jsonDictionary: JsonDictionary){
        self.jsonDictionary = jsonDictionary
    }
    
    var jsonFormmatElementList : String {
        get{
            return "[{\"Int\" : \(intCount)}, {\"String\" : \(stringCount) }, {\"Bool\" : \(boolCount)}]"
        }
    }
    
    var intCount : Int {
        get {
            return self.jsonDictionary.jsonIntElements.count
        }
    }
    
    var stringCount : Int {
        get {
            return self.jsonDictionary.jsonStringElements.count
        }
    }
    
    var boolCount : Int {
        get{
            return self.jsonDictionary.jsonBoolElements.count
        }
    }
    
    var totalCount : Int {
        get {
            return boolCount + stringCount + intCount
        }
    }
    
    private var jsonIntElementList : String {
        get {
            var result = ""
            if jsonDictionary.jsonIntElements.count == 0 {
                return result
            }
            result = printElementList (jsonDictionary.jsonIntElements)
            return result
        }
    }
    
    private var jsonStringElementList : String {
        get {
            var result = ""
            if jsonDictionary.jsonStringElements.count == 0 {
                return result
            }
            result = printElementList (jsonDictionary.jsonStringElements)
            return result
        }
    }
    
    private var jsonBoolElementList : String {
        get {
            var result = ""
            if jsonDictionary.jsonBoolElements.count == 0 {
                return result
            }
            result = printElementList (jsonDictionary.jsonBoolElements)
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
}
