////
////  ObjectJsonParser2.swift
////  JSONParser
////
////  Created by Eunjin Kim on 2017. 12. 13..
////  Copyright © 2017년 JK. All rights reserved.
////
//
//import Foundation
//
//struct ObjectJsonParser2 {
//    typealias regex = JsonScanner.regex
//    var currentState = "S"
//    // 현상태, 읽은기호, 다음기호, 행동, 다음상태
//    private let parsingTableOfObject2 = [["S", regex.STARTCURLYBRACKET, regex.STRING, "shift", "K"],
//                                        [regex.STARTCURLYBRACKET, regex.STARTSQUAREBRACKET, "goToArray", "Array"],
//                                        [regex.STRING, regex.COLON, "saveKey", "V"],
//                                        [regex.STRING, regex.COMMA, "saveValue", "S"],
//                                        [regex.STRING, regex.ENDCURLYBRACKET, "saveValue", "$"],
//                                        [regex.COLON, regex.STRING, "shift", "K"],
//                                        [regex.COLON, regex.BOOLEAN, "shift", "K"],
//                                        [regex.COLON, regex.NUMBER, "shift", "K"],
//                                        [regex.COLON, regex.STARTCURLYBRACKET, "goToObject", "Object"],
//                                        [regex.COLON, regex.STARTSQUAREBRACKET, "goToArray", "Array"],
//                                        [regex.BOOLEAN, regex.COMMA, "saveValue", "S"],
//                                        [regex.NUMBER, regex.COMMA, "saveValue", "S"],
//                                        [regex.BOOLEAN, regex.ENDCURLYBRACKET, "saveValue", "$"],
//                                        [regex.NUMBER, regex.ENDCURLYBRACKET, "saveValue", "$"],
//                                        [regex.COMMA, regex.STRING, "shift", "K"]]
//    
//    private var objectOfJsonData = [String:Any]()
//    private var tokenOfJson: [Token]
//    private var indexOfToken: Int = 0
//    
//    init(token: [Token]) {
//        tokenOfJson = token
//    }
//    
//    mutating func makeJsonData() {
////        while indexOfToken < tokenOfJson.count {
////            for state in 0..<parsingTableOfObject2.count {
////                for index in 0..<parsingTableOfObject2[state].count {
////                    if tokenOfJson[indexOfToken] == parsingTableOfObject2[state][1] {
////                        parsingTableOfObject2[state][0]
////                    }
////
////
////                }
////            }
////        }
////        indexOfToken += 1
////    }
//    //return objectOfJsonData
//}
//
//func shift(){
//    
//}

