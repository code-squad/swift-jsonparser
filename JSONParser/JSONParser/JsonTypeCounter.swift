//
//  JsonParser.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JsonTypeCounter {
    
    func countDataType(token: [Token]) -> DataInfo {
        var dataInfo = DataInfo()
        for info in token {
            if info.id == "NUMBER" {
                dataInfo.countOfNumber += 1
            }
            if info.id == "STRING" {
                dataInfo.countOfString += 1
            }
            if info.id == "BOOLEAN" {
                dataInfo.countOfBool += 1
            }
        }
        return dataInfo
    }
}
