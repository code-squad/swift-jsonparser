//
//  Check.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static func showNumberOfData(_ data:SwiftArray) {
        var outputArray = [String]()
        let swiftArray = data.readArray()
        let numberOfAll = swiftArray.count
        
        outputArray.append("총 \(numberOfAll)개의 데이터 중에")
        if swiftArray.numberOfStringForm() > 0 {
            outputArray.append(" 문자열 \(swiftArray.numberOfStringForm())개")
        }
        if swiftArray.numberOfNumberForm() > 0 {
            outputArray.append(" 숫자 \(swiftArray.numberOfNumberForm())개")
        }
        if swiftArray.numberOfBoolForm() > 0 {
            outputArray.append(" 부울 \(swiftArray.numberOfBoolForm())개")
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
