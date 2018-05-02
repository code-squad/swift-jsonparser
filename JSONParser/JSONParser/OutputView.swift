//
//  OutputView.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol JSONPrintable {
    func totalDataCountDescription() -> String
    func countDataDescription() -> String
    func validateJSONData() -> String
}

struct OutputView {
    static func printJSONData(_ jsonData: JSONPrintable) {
        print("\(jsonData.totalDataCountDescription())\(jsonData.countDataDescription())가 포함되어 있습니다.")
        print(jsonData.validateJSONData())
    }
}
