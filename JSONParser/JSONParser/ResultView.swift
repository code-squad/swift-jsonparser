//
//  ResultView.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 13..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct ResultView {
    
    func resultDicionaryMessage(_ data: [String:Any]) {
        var number = 0
        var string = 0
        var bool = 0
        for i in data.values {
            if i is Int {
                number += 1
            } else if i is String {
                string += 1
            } else if i is Bool {
                bool += 1
            }
        }
        
        if number != 0 && string != 0 && bool != 0 {
            print("총 \(data.count)개의 객체 데이터 중에 숫자 \(number)개, 문자 \(string)개, 부울 \(bool)개가 포함되어 있습니다")
        } else if number != 0 && string != 0 {
            print("총 \(data.count)개의 객체 데이터 중에 숫자 \(number)개, 문자 \(string)개가 포함되어 있습니다")
        } else if number != 0 && bool != 0  {
            print("총 \(data.count)개의 객체 데이터 중에 숫자 \(number)개, 부울 \(bool)개가 포함되어 있습니다")
        } else if string != 0 && bool != 0 {
            print("총 \(data.count)개의 객체 데이터 중에 문자 \(string)개, 부울 \(bool)개가 포함되어 있습니다")
        } else if number != 0 {
            print("총 \(data.count)개의 객체 데이터 중에 숫자 \(number)개가 포함되어 있습니다")
        } else if string != 0 {
            print("총 \(data.count)개의 객체 데이터 중에 문자 \(string)개가 포함되어 있습니다")
        } else if bool != 0  {
            print("총 \(data.count)개의 객체 데이터 중에 부울 \(bool)개가 포함되어 있습니다")
        }
    }
    
    
    func resultArrayMessage(_ data: [String]) {
        print("총 \(data.count)개의 배열 데이터 중에 객체 \(data.count)개 가 포함되어 있습니다.")
    }
    
}

