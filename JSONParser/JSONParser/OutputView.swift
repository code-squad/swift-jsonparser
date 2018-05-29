//
//  OutView.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 21..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    /// JSON 데이터를 받아서 각 항목이 몇개인지 출력
    func printCountOfTypes(json: JSONCount) {
        // 요구조건의 형태대로 출력
        print (json.countValues())
    }
}
