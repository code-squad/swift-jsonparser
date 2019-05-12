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
    /// 포함된 타입들의 멘트를 만드는 함수
    private func buildCountMent(originMent: String, countOfType: (string: Int, int: Int, bool: Int, dictionary: Int)) -> String{
        var printMent = originMent
        switch printMent {
        case "문자열 ":
            let mentAndValue = printMent + String(countOfType.string) + "개"
            printMent = mentAndValue
        case "숫자 ":
            let mentAndValue = printMent + String(countOfType.int) + "개"
            printMent = mentAndValue
        case "부울 ":
            let mentAndValue = printMent + String(countOfType.bool) + "개"
            printMent = mentAndValue
        case "객체 ":
            let mentAndValue = printMent + String(countOfType.dictionary) + "개"
            printMent = mentAndValue
        default: break
        }
        return printMent
    }
    /// 조건에 따라 각 타입별 count를 증가시키는 함수
    private func distinctAndCountOfType(ments: [String], jsonDatum: Json, countOfType: (string: Int, int: Int, bool: Int, dictionary: Int)) -> (ment: String, counts:(string: Int, int: Int, bool: Int, dictionary: Int)) {
        var counts = countOfType
        let json = jsonDatum.countType(jsonDatum: jsonDatum)
        if json == "문자열 " { counts.string += 1 }
        else if json == "숫자 " { counts.int += 1 }
        else if json == "부울 " { counts.bool += 1 }
        else if json == "객체 " { counts.dictionary += 1}
        if ments.contains(json) == false { return (ment: json, counts: counts) }
        else { return (ment: "", counts: counts)}
    }
    /// 각 타입별 멘트를 출력하는 함수
    private func extractionMent(jsonData: [Json]) -> String{
        var countOfType = (string: 0, int: 0, bool: 0, dictionary: 0)
        var ments : [String] = []
        for jsonDatum in jsonData {
            let mentOfType = distinctAndCountOfType(ments: ments, jsonDatum: jsonDatum, countOfType: countOfType)
            ments.append(mentOfType.ment)
            countOfType = mentOfType.counts
            }
        var prints = ments.filter { $0 != "" }
        for mentIndex in 0...prints.count - 1 {
            prints[mentIndex] = buildCountMent(originMent: prints[mentIndex], countOfType: countOfType)
        }
        let setPrint = prints.joined(separator: ", ")
        return setPrint
    }
}
