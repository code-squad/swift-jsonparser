//
//  TypeDictionary.swift
//  JSONParser
//
//  Created by jang gukjin on 09/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TypeDictionary: Json {
    private(set) var json : [String:Json]
    let jsonParser = JsonParser()
    
    init (json: String) throws {
        self.json = [String:Json]()
        var data = json
        data.removeFirst()
        data.removeLast()
        let dictionaryData = data.components(separatedBy: ",")
        for index in 0..<dictionaryData.count {
            let values = dictionaryData[index]
            let value = try jsonParser.ifKeyExist(dictionaryDataElement: values)
            let keyAndValue = values.components(separatedBy: ":")
            self.json[keyAndValue[0]] = try jsonParser.parsingData(beforeData: value)
        }
    }
    
    func countType(jsonDatum: Json) -> String{
        let DictionaryMent = "객체 "
        if (jsonDatum as? TypeDictionary) != nil { return DictionaryMent }
        else { return "" }
    }
}

