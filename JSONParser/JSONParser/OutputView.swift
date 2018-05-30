//
//  OutView.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 21..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    /// JSON 데이터를 받아서 각 항목이 몇개인지 출력
    func printCountOfTypes(json: JSONCount) {
        // 인트형 개수를 받는다
        let countOfInt = json.countInt()
        // 문자형 개수를 받는다
        let countOfString = json.countString()
        // Bool형 개수를 받는다
        let countOfBool = json.countBool()
        // 객체형 개수를 받는다
        let countOfObject = json.countObject()
        
        // 객체형의 경우 객체개수가 닐값이므로 조건문을 준다
        if countOfObject == nil {
            // 총 합을 구한다
            let totalCount = countOfInt + countOfString + countOfBool
            // 요구조건의 형태대로 출력
            print("총 \(totalCount)개의 객체 데이터 중에 문자열 \(countOfString)개, 숫자 \(countOfInt)개, 부울 \(countOfBool)개가 포함되어 있습니다.")
        }
        else {
            // 총 합을 구한다
            let totalCount = countOfInt + countOfString + countOfBool + countOfObject!
            // 요구조건의 형태대로 출력
            print ("총 \(totalCount)개의 배열 데이터 중에 객체 \(countOfObject!)개, 문자열 \(countOfString)개, 숫자 \(countOfInt)개, 부울 \(countOfBool)개가 포함되어 있습니다.")
        }
    }
}
