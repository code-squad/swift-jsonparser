//
//  UsableType.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 13..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol UsableType {}
protocol ArrayUsableType : UsableType {}
protocol ObjectUsableType : UsableType {}

extension String : ArrayUsableType, ObjectUsableType {
    func isWhatType() -> SwiftType {
        return .string
    }
}
extension Double : ArrayUsableType, ObjectUsableType {
    func isWhatType() -> SwiftType {
        return .number
    }
}
extension Bool : ArrayUsableType, ObjectUsableType {
    func isWhatType() -> SwiftType {
        return .bool
    }
}
extension Dictionary : ArrayUsableType {
    func isWhatType() -> SwiftType {
        return .object
    }
}

