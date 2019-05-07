//
//  InputView.swift
//  JSONParser
//
//  Created by jang gukjin on 02/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct InputView {
    /// String?을 입력받는 함수
    func readJson() -> String? {
        print("분석할 JSON 데이터를 입력하세요")
        let json = readLine()
        return json
    }
}
