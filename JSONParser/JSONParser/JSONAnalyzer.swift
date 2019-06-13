////
////  Lexer.swift
////  JSONParser
////
////  Created by JieunKim on 05/06/2019.
////  Copyright © 2019 JK. All rights reserved.
////
//
//import Foundation
//
//struct JSONAnalyzer {
//    static func analyze(data: [String]) throws -> [String] {
//        guard data.first == String(Token.beginArray) && data.last == String(Token.endArray) else {
//            throw JSONError.notArray
//        }
//        var data = data
//        data.removeFirst()
//        data.removeLast()
//        var result = [String]()
//
//        func readLexical(string: String) throws {
//                     result.append(string)
//        }
//        
//        for string in data {
//            try readLexical(string: string)
//        }
//        
//        return result
//    }
//}
//
