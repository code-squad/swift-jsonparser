//
//  Stack.swift
//  JSONParser
//
//  Created by Elena on 20/12/2018.
//  Copyright © 2018 elena. All rights reserved.
//

import Foundation

struct Stack: ParseData {
    // stack Data 
    var dataCount: [String] { return stackData }
    // Array is Start index zero. so returnData add oneData.
    var dataNumber: Int { return (stackData.count)+1 }
    
    private (set) var stackData = [String()]
    
    init(_ data: [String]) {
        self.stackData = data
    }
    
}
