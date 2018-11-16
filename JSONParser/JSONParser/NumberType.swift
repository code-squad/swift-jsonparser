//
//  NumberType.swift
//  JSONParser
//
//  Created by 윤동민 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct NumberType : SwiftType {
    private(set) var data : Double
    
    init(_ jsonData : String) {
        if let convertedNumber = Double(jsonData) { self.data = convertedNumber }
        else { self.data = 0 }
    }
}
