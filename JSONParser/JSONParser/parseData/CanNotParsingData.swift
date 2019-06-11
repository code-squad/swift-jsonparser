//
//  CanNotParsingData.swift
//  JSONParser
//
//  Created by 이희찬 on 11/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct CanNotParsingData {
    
    init(_ canNotParsingData:[String]) {
        self.canNotParsingData = canNotParsingData
    }
    
    var canNotParsingData:[String]
    var count:Int {
        return canNotParsingData.count
    }
    
}
