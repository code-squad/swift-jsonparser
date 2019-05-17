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
    /// 조건에 따라 각 타입별 count를 증가시키는 함수
    private func distinctAndCountOfType(jsonDatum: Json, countOfType: (문자열: Int, 숫자: Int, 부울: Int, 객체: Int)) -> (문자열: Int, 숫자: Int, 부울: Int, 객체: Int) {
        var counts = countOfType
        if jsonDatum is TypeString { counts.문자열 += 1 }
        else if jsonDatum is TypeInt { counts.숫자 += 1 }
        else if jsonDatum is TypeBool { counts.부울 += 1 }
        else if jsonDatum is TypeDictionary { counts.객체 += 1}
        return counts
    }
    /// 각 타입별 멘트를 출력하는 함수
    private func extractionMent(jsonData: [Json]) -> String{
        var countOfType = (문자열: 0, 숫자: 0, 부울: 0, 객체: 0)
        var ment: String
        var prints : [String] = []
        for jsonDatum in jsonData {
            countOfType = distinctAndCountOfType(jsonDatum: jsonDatum, countOfType: countOfType)
            }
        let mirrorCountOfType = Mirror(reflecting: countOfType)
        for (key, value) in mirrorCountOfType.children{
            if value as? Int ?? 0 > 0 {
                ment = "\(key ?? "") \(value)개"
                prints.append(ment)
            }
        }
        let setPrint = prints.filter { $0 != ""}.joined(separator: ", ")
        return setPrint
    }
}
