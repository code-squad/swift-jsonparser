//
//  DataFactory.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 19..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct DataFactory {
    
    func seperateData (userData : String) -> [Any] {
        var temp : [Any] = userData.split(separator: ",").map(String.init)
        for indexOfData in 0..<userData.count {
            temp[indexOfData] = MakeBoolType(oneData: String(temp[indexOfData]))
        }
        for indexOfData in 0..<userData.count {
            
        }
        for indexOfData in 0..<userData.count {
            
        }
    }
    
    private func MakeBoolType (oneData : String) -> Bool {
        if oneData == "true" {
            return true
        } else if oneData == "false" {
            return false
        }
    }
}
