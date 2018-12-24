//
//  OutputView.swift
//  JSONParser
//
//  Created by Elena on 19/12/2018.
//  Copyright © 2018 elena. All rights reserved.
//

import Foundation

struct OutputView {
    func parserResultData(_ shape: JSONResult) {
        print("\(shape.resultDataPrint) \(shape.parserResultPrint)")
    }
    func errorResult() {
        print("지원하는 규격이 아니다.")
    }
}
