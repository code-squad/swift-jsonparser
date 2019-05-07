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
    /// 입력받은 String의 양끝에 "[","]"가 있는지 판단하는 함수
    func distinctArray(inputdata: String?) throws -> String {
        guard let input : String = inputdata, input.first == "[", input.last == "]" else { throw ErrorMessage.notArray }
        return input
    }
}
