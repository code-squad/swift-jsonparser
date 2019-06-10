//
//  JSONToken.swift
//  JSONParser
//
//  Created by JieunKim on 30/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JSONDataType {
     var typeDescription: String { get }
}

extension String: JSONDataType {
     var typeDescription: String {
        return "String"
    }
}

typealias Number = Double
extension Number: JSONDataType {
     var typeDescription: String {
        return "Number"
    }
}

extension Bool: JSONDataType {
     var typeDescription: String {
        return "Bool"
    }
}
