//
//  OutputView.swift
//  JSONParser
//
//  Created by jang gukjin on 02/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    /// 값을 받아와서 출력하는 함수
    func printElements(jsonData: (json: [Json], dataMent:String)) {
        print("총 \(jsonData.json.count)개의 \(jsonData.dataMent) 데이터 중에 ", terminator: "")
        let mentByTypes = extractionMent(jsonData: jsonData.json)
        print("\(mentByTypes)가 포함되어 있습니다.")
    }
    /// 각 타입별 멘트를 출력하는 함수
    private func extractionMent(jsonData: [Json]) -> String{
        var countString = 0
        var countInt = 0
        var countBool = 0
        var countDictionary = 0
        var prints : [String] = []
        for jsonDatum in jsonData {
            let json = jsonDatum.countType(jsonDatum: jsonDatum)
            if json == "문자열 " { countString += 1 }
            else if json == "숫자 " { countInt += 1 }
            else if json == "부울 " { countBool += 1 }
            else if json == "객체 " { countDictionary += 1}
            if prints.contains(json) == false {prints.append("\(json)")}
            }
        for mentIndex in 0...prints.count - 1 {
            switch prints[mentIndex] {
            case "문자열 ":
                let mentAndValue = prints[mentIndex] + String(countString) + "개"
                prints[mentIndex] = mentAndValue
            case "숫자 ":
                let mentAndValue = prints[mentIndex] + String(countInt) + "개"
                prints[mentIndex] = mentAndValue
            case "부울 ":
                let mentAndValue = prints[mentIndex] + String(countBool) + "개"
                prints[mentIndex] = mentAndValue
            case "객체 ":
                let mentAndValue = prints[mentIndex] + String(countDictionary) + "개"
                prints[mentIndex] = mentAndValue
            default: break
            }
        }
        let setPrint = prints.joined(separator: ", ")
        return setPrint
    }
}
