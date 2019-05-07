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
    func printElements(jsonDatas: [Json]) {
        var prints : [String] = []
        print("총 \(jsonDatas.count)개의 데이터 중에", terminator: "")
        for jsonData in jsonDatas {
            let json = jsonData.json.countType(jsonDatas: jsonDatas)
            prints.append(" \(json.ment)\(json.value)개")
        }
        let setPrint = Set(prints).joined(separator: ",")
        print("\(setPrint)가 포함되어 있습니다.")
    }
}
