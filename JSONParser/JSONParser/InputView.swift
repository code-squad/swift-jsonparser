//
//  InputView.swift
//  JSONParser
//
//  Created by 윤지영 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct InputView {
    static private let guideMessage = "분석할 JSON 데이터를 입력하세요."

    static func readInput() -> String {
        print(guideMessage)
        guard let input: String = readLine() else { return String() }
        return input
    }
}
