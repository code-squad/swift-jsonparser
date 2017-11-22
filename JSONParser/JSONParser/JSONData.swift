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
    var prettyData: [Any] { get set }
    var count: Int { get }
    var dataCountOfEach: (string: Int, number: Int, bool: Int, nestedObject: Int, nestedArray: Int) { get set }
}
