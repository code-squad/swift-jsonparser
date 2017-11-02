//
//  JSONData.swift
//  JSONParser
//
//  Created by yangpc on 2017. 11. 2..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// Value는 Number, Bool, String을 표현하기 위함이고, Any는 JSONObject({String:Value...})까지 포함하는 의미로 Any를 사용하였다.
struct JSONData {
    
    private(set) var array: [Any]
    
    init(array: [Any]) {
        self.array = array
    }
}

