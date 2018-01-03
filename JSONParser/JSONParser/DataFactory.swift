//
//  DataFactory.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 19..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation
typealias ObjectDictionary = [String : MyValues]

struct DataFactory {
    
    func generateData (_ data : String) -> MyValues {
        let dataBeforeSeperating = data.sliceData()
        var seperatedArray : [MyValues] = []
        var seperatedObeject : [String:MyValues] = [:]
        var temp : ( key : String, value : MyValues )
        for indexOfData in 0..<dataBeforeSeperating.count {
            if data.checkDataType() is [MyValues] {
                seperatedArray.append((dataBeforeSeperating[indexOfData]).checkDataType())
                continue
            }
            temp = dataBeforeSeperating[indexOfData].generateOneObjectData()
            seperatedObeject.updateValue(temp.value, forKey: temp.key)
        }
        guard data.checkDataType() is [MyValues] == false else { return seperatedArray }
        return seperatedObeject
        
    }
    
    

    



}
