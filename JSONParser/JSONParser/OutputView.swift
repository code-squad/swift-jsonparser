//
//  OutputView.swift
//  JSONParser
//
//  Created by JH on 22/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    func show(string: String) {
        print(string)
    }
    
    func showCount(json: JsonType) {
        
        let countInfo = json.countInfo.map { "\($0.key) \($0.value)개" }
        let output = countInfo.joined(separator: ", ")
        
        print("총 \(json.count)개의 데이터 중에 \(output)가 포함되어 있습니다.")
    }
}
