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
        var prints : [String] = []
        print("총 \(jsonData.count)개의 데이터 중에", terminator: "")
        for jsonDatum in jsonData {
            let json = jsonDatum.countType(jsonData: jsonData)
            prints.append(" \(json.ment)\(json.value)개")
        }
        let setPrint = Set(prints).joined(separator: ",")
        print("\(setPrint)가 포함되어 있습니다.")
    }
}
