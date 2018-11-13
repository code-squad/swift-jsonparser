//
//  Check.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static func showNumberOfData(_ data:Collection) {
        var outputArray = [String]()
        let numberOfAll = data.readNumberOfElements()
        
        guard numberOfAll > 0 else {print("데이터가 없습니다."); return}
        
        outputArray.append("총 \(numberOfAll)개의 데이터 중에")
        if data.readNumberOfString() > 0 {
            outputArray.append(" 문자열 \(data.readNumberOfString())개")
        }
        if data.readNumberOfNumber() > 0 {
            outputArray.append(" 숫자 \(data.readNumberOfNumber())개")
        }
        if data.readNumberOfBool() > 0 {
            outputArray.append(" 부울 \(data.readNumberOfBool())개")
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


