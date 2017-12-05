//
//  OutputVIew.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    func showResult(_ countInfo: CountingInfo) {
        print("\(countInfo.valueNum)개 데이터 중에 \(countInfo.makeResultMessage())가 포함되어 있습니다.")
    }
    
}
