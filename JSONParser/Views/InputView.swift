//
//  InputView.swift
//  JSONParser
//
//  Created by hw on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct InputView {
    static func readStringJsonData(_ prompt: String = "분석할 JSON 데이터를 입력하세요.") throws -> String {
        print (prompt)
        guard let input = readLine() else{
            throw ErrorCode.noInput
        }
        return input
    }
}
