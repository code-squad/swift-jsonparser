//
//  InputView.swift
//  JSONParser
//
//  Created by hw on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

//[ 10, 21, 4, 314, 99, 0, 72 ]
//총 7개의 데이터 중에 숫자 7개가 포함되어 있습니다.

//[ 10, "jk", 4, "314", 99, "crong", false ]
// 총 7개의 데이터 중에 문자열 3개, 숫자 3개, 부울 1개가 포함되어 있습니다.

struct InputView {
    static func readStringJsonData(_ prompt: String = "분석할 JSON 데이터를 입력하세요.") throws -> String {
        print (prompt)
        guard let input = readLine() else{
            throw ErrorCode.noInput
        }
        return input
    }
    
}
