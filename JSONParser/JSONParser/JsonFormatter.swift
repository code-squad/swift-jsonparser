//
//  JsonFormatter.swift
//  JSONParser
//
//  Created by hw on 10/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonFormatter{
    
    private var jsonPairs: JsonArray
    
    init(jsonArray: JsonArray){
        self.jsonPairs = jsonArray
    }
    
    var jsonFormmatClusteredElementList : String {
        get{
            return "[{\"Int\" : \(jsonIntElementList)}, {\"String\" : \(jsonStringElementList) }, {\"Bool\" : \(jsonBoolElementList)}]"
        }
    }
    
    var intCount : Int {
        get {
            return self.jsonPairs.jsonIntElements.count
        }
    }

    var stringCount : Int {
        get {
            return self.jsonPairs.jsonStringElements.count
        }
    }

    var boolCount : Int {
        get{
            return self.jsonPairs.jsonBoolElements.count
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
            if jsonPairs.jsonIntElements.count == 0 {
                return result
            }
            result = printElementList (jsonPairs.jsonIntElements)
            return result
        }
    }
    
    private var jsonStringElementList : String {
        get {
            var result = ""
            if jsonPairs.jsonStringElements.count == 0 {
                return result
            }
            result = printElementList (jsonPairs.jsonStringElements)
            return result
        }
    }
    
    private var jsonBoolElementList : String {
        get {
            var result = ""
            if jsonPairs.jsonBoolElements.count == 0 {
                return result
            }
            result = printElementList (jsonPairs.jsonBoolElements)
            return result
        }
    }
    
    private func printElementList (_ list : [String]) ->  String {
        var result = "[ "
        for index in 0..<list.count-1 {
            result += "\(list[index]), "
        }
        result += "\(list[list.count-1]) ]"
        return result
    }
}
