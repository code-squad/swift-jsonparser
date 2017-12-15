//
//  JsonParser.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//
import Foundation

struct JsonTypeCounter {
    
    func findTypeOfData(jsonData: Any) throws -> DataInfo {
        var dataInfo = DataInfo()
        switch jsonData {
            case is Dictionary<String, Any>:
                try dataInfo = countDataOfObject(jsonData: jsonData as! Dictionary)
            case is [Any]:
                try dataInfo = countDataOfArray(jsonData: jsonData as! Array)
            default:
                print("error")
        }
        return dataInfo
    }
    
    func countDataOfObject(jsonData: [String:Any]) throws -> DataInfo {
        var dataInfo = DataInfo()
        for data in jsonData{
            if (data.value as? Int) != nil {
                dataInfo.countOfNumber += 1
            }else if (data.value as? String) != nil {
                dataInfo.countOfString += 1
            }else if (data.value as? Bool) != nil {
                dataInfo.countOfBool += 1
            }else if (data.value as? Dictionary<String, Any>) != nil {
                dataInfo.countOfObject += 1
            }else if (data.value as? Array<Any>) != nil {
                dataInfo.countOfArray += 1
            }
        }
        return dataInfo
    }
    
    func countDataOfArray(jsonData: [Any]) throws -> DataInfo {
        var dataInfo = DataInfo()
        for data in jsonData{
            if (data as? Int) != nil {
                dataInfo.countOfNumber += 1
            }else if (data as? String) != nil {
                dataInfo.countOfString += 1
            }else if (data as? Bool) != nil {
                dataInfo.countOfBool += 1
            }else if (data as? Dictionary<String, Any>) != nil {
                dataInfo.countOfObject += 1
            }else if (data as? Array<Any>) != nil {
                dataInfo.countOfArray += 1
            }
        }

        return dataInfo
    }

}
