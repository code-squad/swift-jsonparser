//
//  StringType.swift
//  JSONParser
//
//  Created by 윤동민 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct StringType : SwiftType {
    private(set) var data : String
    
    init(_ jsonData : String) {
        var jsonData = jsonData
        jsonData.remove(at: jsonData.startIndex)
        jsonData.remove(at: jsonData.index(before: jsonData.endIndex))
        self.data = jsonData
    }
}
