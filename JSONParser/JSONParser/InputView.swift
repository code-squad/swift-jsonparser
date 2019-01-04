//
//  InputView.swift
//  JSONParser
//
//  Created by Elena on 19/12/2018.
//  Copyright © 2018 elena. All rights reserved.
//

import Foundation

struct InputView {
    
    private static func readInput(ment: String) -> String {
        print(ment)
        return readLine() ?? ""
    }
    
    static func getUserString() -> String {
        let jsonParser = readInput(ment: "분석할 JSON 데이터를 입력하세요.")
        return jsonParser
    }
}
