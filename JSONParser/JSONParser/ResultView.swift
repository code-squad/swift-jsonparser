//
//  ResultView.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 13..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct ResultView {
    
    func resultMessage(_ numberCount: Int,_ stringCount: Int,_ boolCount: Int, dataArray: [String]) {
        
        if numberCount != 0 && stringCount == 0 && boolCount == 0{
            print("총 \(dataArray.count)개의 데이터 중에 숫자 \(numberCount)개가 포함되어 있습니다.")
        }
        if numberCount == 0 && stringCount != 0 && boolCount == 0{
            print("총 \(dataArray.count)개의 데이터 중에 문자열 \(stringCount)개가 포함되어 있습니다.")
        }
        if numberCount == 0 && stringCount == 0 && boolCount != 0{
            print("총 \(dataArray.count)개의 데이터 중에 부울 \(boolCount)개가 포함되어 있습니다.")
        }
        if numberCount != 0 && stringCount != 0 && boolCount != 0{
            print("총 \(dataArray.count)개의 데이터 중에 문자열 \(stringCount)개, 숫자 \(numberCount)개, 부울 \(boolCount)개가 포함되어 있습니다.")
        }
        if numberCount != 0 && stringCount != 0 && boolCount == 0{
            print("총 \(dataArray.count)개의 데이터 중에 문자열 \(stringCount)개, 숫자 \(numberCount)개가 포함되어 있습니다.")
        }
        if numberCount != 0 && stringCount == 0 && boolCount != 0{
            print("총 \(dataArray.count)개의 데이터 중에 숫자 \(numberCount)개, 부울 \(boolCount)개가 포함되어 있습니다.")
        }
        if numberCount == 0 && stringCount != 0 && boolCount != 0{
            print("총 \(dataArray.count)개의 데이터 중에 문자열 \(stringCount)개, 부울 \(boolCount)개가 포함되어 있습니다.")
        }
        
    }
    
}
