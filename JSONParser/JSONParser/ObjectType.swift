//
//  ObjectType.swift
//  JSONParser
//
//  Created by 윤동민 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct ObjectType : SwiftType {
    private(set) var data : Dictionary<String, SwiftType>
    
    init(_ jsonData : String) {
        data = ["jsonData" : StringType(jsonData)]
        
    }
}
