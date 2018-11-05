//
//  InputView.swift
//  JSONParser
//
//  Created by 윤동민 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct InputView {
    // 사용자의 입력을 받음
    static func UserInput(message : String) -> String{
        print(message)
        guard let input = readLine() else { return "" }
        return input
    }
}
