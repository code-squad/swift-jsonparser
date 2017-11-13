//
//  InputView.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    func readInput() -> Array<String> {
        var readInput : String = ""
        var flag : Bool = false
        while !flag {
            print("분석할 JSON 데이터를 입력하세요.")
            readInput = readLine() ?? "[]"
            do {
                try readInput.isJSONPattern()
                flag = true
            } catch GrammarChecker.ErrorMessage.notJSONPattern {
                print("지원하지 않는 형식을 포함하고 있습니다.")
            } catch {
                print("입력이 정상적이지 않습니다.")
            }
        }
        return readInput.getElementsAll()
    }
}
