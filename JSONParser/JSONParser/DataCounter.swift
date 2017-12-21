//
//  DataCounter.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct DataCounter {
    func countNumberOfData (_ userData : Any) -> MyCount {
        switch userData {
        case is [Any] :
            let temp : [Any] = userData as! [Any]
            return temp.countNumber()
        case is [String:Any] :
            let temp : [String:Any] = userData as! [String : Any]
            return temp.countNumber()
        default:
            break
        }
        return MyCount()
    }
}
