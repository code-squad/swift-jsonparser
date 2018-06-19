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
    func printCount(jsonInformation: JSONInformation, jsonType: String) {
        // 결과 출력용 메세지
        var resultCountMessage = " 데이터 중에"
        let endCountMessage = "가 포합되어 있습니다."
        // 0개 이상의 경우 메세지를 추가한다
        if jsonInformation.countOfInt > 0 {
            resultCountMessage += " 숫자 \(jsonInformation.countOfInt)개,"
        }
        if jsonInformation.countOfString > 0 {
            resultCountMessage += " 문자열 \(jsonInformation.countOfString)개,"
        }
        if jsonInformation.countOfBool > 0 {
            resultCountMessage += " 부울 \(jsonInformation.countOfBool)개,"
        }
        if jsonInformation.countOfObject > 0 {
            resultCountMessage += " 객체 \(jsonInformation.countOfObject)개,"
        }
        if jsonInformation.countOfArray > 0 {
            resultCountMessage += " 배열 \(jsonInformation.countOfArray)개,"
        }
        // 맨 뒤의 , 를 삭제한다.
        resultCountMessage.removeLast()
        // 총 합을 구한다
        let totalCount = jsonInformation.countOfInt + jsonInformation.countOfString + jsonInformation.countOfBool + jsonInformation.countOfObject + jsonInformation.countOfArray
        
        // 요구조건의 형태대로 카운트 출력
        print("총 \(totalCount)개의 \(jsonType) 데이터 중에\(resultCountMessage)\(endCountMessage)")
    }
    
    /// 요구조건에서 요구하는 내용을 출력한다
    mutating func printJSON(json: JSONCount){
        // 카운트를 출력한다
        printCount(jsonInformation: json.jsonInformation, jsonType: json.type)
        // 세부 내용을 출력한다
        print(json.jsonInformation.detailOfJSON)
    }
}
