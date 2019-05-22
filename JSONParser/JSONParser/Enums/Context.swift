//
//  Context2.swift
//  JSONParser
//
//  Created by 이동영 on 23/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum Context{
    case Array
    case Value
    case String
    
    func canInclude(context: Context) -> Bool {
        switch self {
        case .Array: // 배열은
            return context == .Value || context == .Array  // Value,Array 포함할수 있어
        case .Value:
            return context != .Value // Value 빼곤 다 포함할 수 있어
        case .String:
            return false // 못해
        }
    }
    
    func isFinish(where:Character) -> Bool {
        switch self {
        case .Array:
            ()
        case .Value:
            ()
        case .String:
            ()
        }
        return false
    }
    
}
