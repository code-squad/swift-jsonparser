//
//  OutputView.swift
//  JSONParser
//
//  Created by 이희찬 on 03/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func printResult(data:countable) {
        
        if data.countNumbers.object > 0 {
            print("총\(data.countNumbers.allData) 개의 데이터 중에 객체 \(data.countNumbers.object)개, 문자열 \(data.countNumbers.string)개, 숫자 \(data.countNumbers.int)개, 부울 \(data.countNumbers.bool)개가 포함되어 있습니다.")
            return
        }
        
        print("총\(data.countNumbers.allData) 개의 데이터 중에 문자열 \(data.countNumbers.string)개, 숫자 \(data.countNumbers.int)개, 부울 \(data.countNumbers.bool)개가 포함되어 있습니다.")
        
    }
    
}
