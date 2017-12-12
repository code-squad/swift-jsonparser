//
//  ValueCounter.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct ValueCounter {
    var JSONDataList : [JSONData] = []
    
    init (_ data : [JSONData]) {
        self.JSONDataList = data
    }
    
    func countingValues() -> CountingInfo{
        var countOfInt = 0
        var countOfBool = 0
        var countOfString = 0
        let countOfJSONData = JSONDataList.count
        
        for datum in JSONDataList {
            switch datum {
            case .IntegerValue :
                countOfInt += 1
                
            case .BoolValue:
                countOfBool += 1
                
            case .StringValue :
                countOfString += 1
            
            default :
                countOfString += 0
            }
        }
        return CountingInfo(countOfInt, countOfBool, countOfString, countOfJSONData)
    }

}
