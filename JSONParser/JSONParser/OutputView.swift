//
//  OutputView.swift
//  JSONParser
//
//  Created by jang gukjin on 02/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    func printElements(jsonDatas: [Json], elementType: ElementType) {
        print("총 \(jsonDatas.count)개의 데이터 중에", terminator: "")
        print(" \(elementType.countType(jsonDatas: jsonDatas)),")
    }
}
