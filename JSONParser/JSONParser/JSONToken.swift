//
//  JSONToken.swift
//  JSONParser
//
//  Created by JieunKim on 30/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JSONDataType {
    static var typeDescription: String { get }
}

extension String: JSONDataType {
    static var typeDescription: String {
        return "String"
    }
}

extension Int: JSONDataType {
    static var typeDescription: String {
        return "Int"
    }
}

extension Bool: JSONDataType {
    static var typeDescription: String {
        return "Bool"
    }
}
