//
//   FirstObjectProtocol.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

protocol FirstClassObject {
    func countParsingData() -> DataInfo
}

extension Dictionary: FirstClassObject {
    func countParsingData() -> DataInfo {
        var dataInfo = DataInfo()
        for data in self {
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
}

extension Array: FirstClassObject {
    func countParsingData() -> DataInfo {
        var dataInfo = DataInfo()
        for data in self {
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
