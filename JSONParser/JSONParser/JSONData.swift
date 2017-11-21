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
    var dataCountOfEach: (string: Int, number: Int, bool: Int, nestedObject: Int, nestedArray: Int) { get set }
    var prettyData: [Any] { get set }
    
    mutating func setCounts()
    
    mutating func makePrettyData()

    mutating func addValuesOfData() -> [Any]
    
}

extension JSONData {
    
    func makeDataString(from data: Any) -> Any {
        switch data {
        case let value as String:
            return "\"" + value + "\""
        default:
            return data
        }
    }

    func appendAnys(to dest: inout [Any], of datum: Any...) {
        dest.append(contentsOf: datum)
    }
    
    mutating func setEachCounts(of datum: Any) {
        switch datum {
        case is TYPEString: self.dataCountOfEach.string += 1
        case is TYPENumber: self.dataCountOfEach.number += 1
        case is TYPEBool: self.dataCountOfEach.bool += 1
        case is TYPEArray: self.dataCountOfEach.nestedArray += 1
        case is TYPEObject: self.dataCountOfEach.nestedObject += 1
        default: break
        }
    }
    
}
