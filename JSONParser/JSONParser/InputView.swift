//
//  InputView.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct InputView {
    static func readInput(ment:String = "분석할 JSON 데이터를 입력하세요.") -> String {
        print(ment)
        return readLine() ?? ""
    }
}
