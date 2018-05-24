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
    func printCountOfTypes(json: JSON) {
        // 숫자형 타입의 개수를 받을 변수 선언
        let countOfNumber = json.countNumberType()
        // 문자형 타입의 개수를 받을 변수 선언
        let countOfLetter = json.countLetterType()
        // Bool 형 타입의 개수를 받을 변수 선언
        let countOfBool = json.countBoolType()
        // 합계 계산
        let totalCount = countOfNumber + countOfLetter + countOfBool
        // 요구조건의 형태대로 출력
        print ("총 \(totalCount)개의 데이터 중에 문자열 \(countOfLetter)개, 숫자 \(countOfNumber)개, 부울 \(countOfBool)개가 포함되어 있습니다.")
    }
}
