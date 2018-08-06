//
//  OutputView.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 2..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    public static func printJson(to json:Json){
        var counts = json.countJson()
        var message = ""
        if let totalCount = counts.removeValue(forKey: "총") {
            message = "총 \(totalCount)개의 데이터 중에 "
        }
        
        for count in counts {
            if count.value > 0 {
                message = message + "\(count.key) \(count.value)개,"
            }
        }
        message.removeLast() // 마지막 , 는 제거 합니다.
        message = message + "가 포함되어 있습니다."
        print(message)
    }
    
}
