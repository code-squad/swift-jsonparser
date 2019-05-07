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
    func printElements(jsonData: [Json]) {
        var countString = 0
        var countInt = 0
        var countBool = 0
        var prints : [String] = []
        print("총 \(jsonData.count)개의 데이터 중에 ", terminator: "")
        for jsonDatum in jsonData {
            let json = jsonDatum.countType(jsonDatum: jsonDatum)
            if json == "문자열 " { countString += 1 }
            else if json == "숫자 " { countInt += 1 }
            else if json == "부울 " { countBool += 1 }
            //prints.append(" \(json)")
            if prints.contains(json) == false {prints.append("\(json)")}
        }
        var mentAndValues: [String] = []
        for ment in prints {
            switch ment {
            case "문자열 ":
                let mentAndValue = ment + String(countString) + "개"
                mentAndValues.append(mentAndValue)
            case "숫자 ":
                let mentAndValue = ment + String(countInt) + "개"
                mentAndValues.append(mentAndValue)
            case "부울 ":
                let mentAndValue = ment + String(countBool) + "개"
                mentAndValues.append(mentAndValue)
            default: break
            }
        }
        let setPrint = mentAndValues.joined(separator: ", ")
        print("\(setPrint)가 포함되어 있습니다.")
    }
}
