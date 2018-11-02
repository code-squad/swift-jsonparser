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
        let numberOfAll = data.readStrings().count + data.readNumbers().count + data.readBools().count
        
        outputArray.append("총 \(numberOfAll)개의 데이터 중에")
        if data.readStrings().count > 0 {
            outputArray.append(" 문자열 \(data.readStrings().count)개")
        }
        if data.readNumbers().count > 0 {
            outputArray.append(" 숫자 \(data.readNumbers().count)개")
        }
        if data.readBools().count > 0 {
            outputArray.append(" 부울 \(data.readBools().count)개")
        }
        outputArray.append("가 포함되어 있습니다.")
        showResult(outputArray)
    }
    
    static private func showResult(_ result:[String]) {
        for i in result {
            print(i, terminator: "")
            guard i != result[result.startIndex] else {continue}
            guard i != result[result.endIndex - 1] else {continue}
            guard i != result[result.endIndex - 2] else {continue}
            print(",", terminator: "")
        }
        print("")
    }
}
