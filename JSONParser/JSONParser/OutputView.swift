//
//  Check.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static func showNumberOfData(_ number:NumberByType, type:TypeInfo) {
        guard number.numberOfAll() > 0 else {print("데이터가 없습니다."); return}
        
        print("총 \(number.numberOfAll())개의 \(type.rawValue) 데이터 중에", terminator: "")
        showResult(readInfo(number))
        print("가 포함되어 있습니다.", terminator: "")
        print("")
    }
    
    static private func readInfo(_ number:NumberByType) -> [String] {
        var outputArray = [String]()
        if number.numberOfString() > 0 {
            outputArray.append(" 문자열 \(number.numberOfString())개")
        }
        if number.numberOfNumber() > 0 {
            outputArray.append(" 숫자 \(number.numberOfNumber())개")
        }
        if number.numberOfBool() > 0 {
            outputArray.append(" 부울 \(number.numberOfBool())개")
        }
        if number.numberOfObject() > 0 {
            outputArray.append(" 객체 \(number.numberOfObject())개")
        }
        if number.numberOfArray() > 0 {
            outputArray.append(" 배열 \(number.numberOfArray())개")
        }
        return outputArray
    }
    
    static private func showResult(_ result:[String]) {
        for numberOfData in result {
            print(numberOfData, terminator: "")
            guard numberOfData != result[result.endIndex - 1] else {continue}
            print(",", terminator: "")
        }
    }
    
    static func showJsonForm(_ jsonData:JsonCollection) {
        if jsonData.type() == .array {
            
        }
        if jsonData.type() == .object {
            
        }
    }
}


