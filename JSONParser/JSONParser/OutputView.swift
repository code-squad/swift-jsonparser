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
        // 타입별로 개수를 받는다
        let countOfInt = json.countOfInt
        let countOfString = json.countOfString
        let countOfBool = json.countOfBool
        let countOfObject = json.countOfObject
        
        // 결과 출력용 메세지
        var resultMessage = "개의 객체 데이터 중에"
        let endMessage = "가 포합되어 있습니다."
        // 0개 이상의 경우 메세지를 추가한다
        if countOfInt > 0 {
            resultMessage += " 숫자 \(countOfInt)개,"
        }
        if countOfString > 0 {
            resultMessage += " 문자열 \(countOfString)개,"
        }
        if countOfBool > 0 {
            resultMessage += " 부울 \(countOfBool)개,"
        }
        
        // 객체형의 경우 객체개수가 닐값이므로 조건문을 준다
        if countOfObject == nil {
            // 총 합을 구한다
            let totalCount = countOfInt + countOfString + countOfBool
            // 메세지의 마지막 , 를 삭제한다
            resultMessage.removeLast()
            // 요구조건의 형태대로 출력
            print("총 \(totalCount)\(resultMessage)\(endMessage)")
        }
        else {
            // 총 합을 구한다
            let totalCount = countOfInt + countOfString + countOfBool + countOfObject!
            // 0개 이상의 경우 메세지를 추가한다
            if countOfObject! > 0 {
                resultMessage += " 객체 \(countOfObject!),"
            }
            // 메세지의 마지막 , 를 삭제한다
            resultMessage.removeLast()
            // 요구조건의 형태대로 출력
            print("총 \(totalCount)\(resultMessage)\(endMessage)")
        }
    }
}
