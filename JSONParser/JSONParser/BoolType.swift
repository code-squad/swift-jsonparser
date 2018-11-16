//
//  BoolType.swift
//  JSONParser
//
//  Created by 윤동민 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct BoolType : SwiftType {
    private(set) var data : Bool
    
    init(_ jsonData : String) {
        if jsonData == "true" { self.data = true }
        else { self.data = false }
    }
}
