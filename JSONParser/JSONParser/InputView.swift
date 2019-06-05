//
//  InputView.swift
//  JSONParser
//
//  Created by JieunKim on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum Direction: String {
    case request = "분석할 JSON 데이터를 입력하세요."
}

struct InputView {
    static func ask(for direction: Direction) throws -> String {
        print(direction.rawValue)
        guard let data = readLine() else {
            throw JSONError.wrongValue
        }
        return data
    }
}
