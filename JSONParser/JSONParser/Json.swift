//
//  Json.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 6..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol Jsonable {
    func countData() -> (Int,Int,Int,Int,Int)
    func generateData() -> String
}

enum JsonType:Equatable {
    case string(String)
    case int(Int)
    case bool(Bool)
    case object([String:JsonType])
    case array([JsonType])
}

extension Jsonable {
    func makeArray(intent : Int, elements:[JsonType]) -> String {
        var message = "["
        for value in elements {
            if message.hasSuffix("}, ") {
                message += "\n"
                message += "\t"
            }
            switch value {
            case .string(let element):
                message += "\(element), "
            case .int(let element):
                message += "\(String(element)), "
            case .bool(let element):
                message += "\(String(element)), "
            case .object(let element):
                message += "\(self.makeObject(intent: intent + 1, elements: element)), "
            case .array(let element):
                message += "\(self.makeArray(intent: intent + 1, elements: element)), "
            }
        }
        message.removeLast(2) // for remove last ","
        if message.hasSuffix("]") {
            message += "\n"
        }
        message += "]"
        return message
    }
    
    func makeObject(intent : Int, elements : [String:JsonType]) -> String {
        var message = "{"
        message += "\n"
        for (key,value) in elements {
            for _ in 0..<intent {
                message += "\t"
            }
            switch value {
            case .string(let element):
                message += "\(key) : \(element),"
            case .int(let element):
                message += "\(key) : \(String(element)),"
            case .bool(let element):
                message += "\(key) : \(String(element)),"
            case .object(let element):
                message += "\(key) : "
                message += "\(self.makeObject(intent: intent + 1, elements: element)),"
            case .array(let element):
                message += "\(key) : "
                message += "\(self.makeArray(intent: intent + 1, elements: element)),"
            }
            message += "\n"
        }
        message.removeLast(2) // for remove last "," (뒤에서 두번째 index를 삭제)
        message += "\n"
        for _ in 0..<intent-1 {
            message += "\t"
        }
        message += "}"
        return message
    }
}
