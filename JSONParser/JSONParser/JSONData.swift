//
//  JSONData.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 22..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

protocol JSONData {
    typealias TYPEObject = [String:Any]
    typealias TYPEArray = [Any]
    typealias TYPEString = String
    typealias TYPENumber = Int
    typealias TYPEBool = Bool
    var count: Int { get }
    func generateJSONReport() -> String
    func generatePrettyJSONData() -> String
}
