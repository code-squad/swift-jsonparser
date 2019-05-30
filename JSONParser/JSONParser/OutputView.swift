//
//  OutputView.swift
//  JSONParser
//
//  Created by jang gukjin on 02/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    private func dictionaryToArray(dictionary: [String:Json]) -> [Json]{
        var convertedData: [Json] = []
        for (key, _) in dictionary{
            convertedData.append(dictionary[key]!)
        }
        return convertedData
    }
    
    /// 값을 받아와서 출력하는 함수
    func printElements(jsonParser: JsonParser, dataMent:String) {
        //let jsonParser = JsonParser()
        var countMent: String = ""
        var jsonData: [Json] = []
        if dataMent == "배열" {
            countMent = "\(jsonParser.arrayJsonData.count)"
            jsonData = jsonParser.arrayJsonData
        } else if dataMent == "객체" {
            countMent = "\(jsonParser.dictionaryJsonData.count)"
            jsonData = dictionaryToArray(dictionary: jsonParser.dictionaryJsonData)
        }
        print("총 \(countMent)개의 \(dataMent) 데이터 중에 ", terminator: "")
        let mentByTypes = MentOfCounts.makeMent(jsonData: jsonData)
        print("\(mentByTypes)가 포함되어 있습니다.")
    }
}
