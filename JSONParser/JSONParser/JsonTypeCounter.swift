//
//  JsonParser.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//
import Foundation

struct JsonTypeCounter {
    
    func findTypeOfData(jsonData: FirstClassObject) throws -> (dataInfo: DataInfo, jsonData: FirstClassObject) {
        let dataInfo = jsonData.countParsingData()
        return (dataInfo, jsonData)
    }
    
}
