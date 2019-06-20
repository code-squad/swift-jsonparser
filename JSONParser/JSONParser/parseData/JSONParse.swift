//
//  JSONParser.swift
//  JSONParser
//
//  Created by 이희찬 on 11/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol countable:JSONValue {
    var countNumbers:(string: Int, int: Int, bool: Int, allData: Int, object: Int) { get }
}

struct JSONObject:countable {
    init(parsingData:[String:JSONValue], Numbers:CountNumbers) {
        self.dictionary = parsingData
        (self.countString, self.countInt, self.countBool) = Numbers
    }
    private var dictionary:[String:JSONValue] = [:]
    private var countString:Int = 0, countInt:Int = 0, countBool:Int = 0, countObject:Int = 0
    private var countAllData:Int { return dictionary.count}
    var countNumbers:(string: Int, int: Int, bool: Int, allData: Int, object: Int) {
        return (self.countString, self.countInt, self.countBool, self.countAllData, self.countObject)
    }
    var typeDescription: String { return "JSONParseObject" }
}

struct JSONArray:countable {
    init(parsingData:[JSONValue], Numbers:CountNumbers, objectNumber:Int = 0) {
        self.array = parsingData
        (self.countString, self.countInt, self.countBool) = Numbers
        self.countObject = objectNumber
    }
    private var array:[JSONValue] = []
    private var countString:Int = 0, countInt:Int = 0, countBool:Int = 0, countObject:Int = 0
    private var countAllData:Int { return array.count}
    var countNumbers:(string: Int, int: Int, bool: Int, allData: Int, object: Int) {
        return (self.countString, self.countInt, self.countBool, self.countAllData, self.countObject)
    }
    var typeDescription: String { return "JSONParseArray" }
}


