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
        let mentByTypes = MentOfCounts.makeMent(jsonData: jsonData.json)
        print("\(mentByTypes)가 포함되어 있습니다.")
    }
}
