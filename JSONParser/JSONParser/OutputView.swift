//
//  OutputView.swift
//  JSONParser
//
//  Created by yangpc on 2017. 10. 30..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static func printAnalyzeResult(_ jsonData: JSONData) {
        var typeCountDictionary = [String:Int]()
        if jsonData.array.count == 1 {
            guard let object = jsonData.array[0] as? JSONObject else { return }
            print("총 \(object.dictionary.count) 개의 객체 데이터 중에", terminator: "")
            typeCountDictionary = JSONTypeCount.calculateNumberOfType(Array(object.dictionary.values))
        } else {
            print("총 \(jsonData.array.count) 개의 배열 데이터 중에", terminator: "")
            typeCountDictionary = JSONTypeCount.calculateNumberOfType(jsonData.array)
        }
        for (type,count) in typeCountDictionary where count != 0 {
            print(" \(type) \(count)개", terminator: "")
        }
        print("가 포함되어 있습니다.")
    }

}



