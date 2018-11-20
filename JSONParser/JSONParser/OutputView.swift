//
//  Check.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static func showNumberOfData(_ number:NumberByType, type:String) {
        var outputArray = [String]()
        
        guard number.numberOfAll() > 0 else {print("데이터가 없습니다."); return}
        outputArray.append("총 \(number.numberOfAll())개의 \(type) 데이터 중에")
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
        outputArray.append("가 포함되어 있습니다.")
        showResult(outputArray)
    }
    
    static private func showResult(_ result:[String]) {
        for numberOfData in result {
            print(numberOfData, terminator: "")
            guard numberOfData != result[result.startIndex] else {continue}
            guard numberOfData != result[result.endIndex - 1] else {continue}
            guard numberOfData != result[result.endIndex - 2] else {continue}
            print(",", terminator: "")
        }
        print("")
    }
}


