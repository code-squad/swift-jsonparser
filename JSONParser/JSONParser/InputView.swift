//
//  InputView.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    func read() -> String? {
        let userRawData = readLine()
        do {
            return try check(userRawData)
        } catch ErrorCode.invalidJSONStandard {
            print("JSON규격에 맞지않습니다. 올바른 입력값을 넣어주세요 :)")
            return nil
        } catch ErrorCode.invalidInputString {
            print("입력값을 확인해주세요 :)")
            return nil
        } catch {
            return nil
        }
    }
    
    private func check(_ value: String?) throws -> String? {
        guard let safeValue = value else {
            throw ErrorCode.invalidInputString
        }
        if safeValue.hasPrefix("[") {
            return safeValue
        } else {
            throw ErrorCode.invalidJSONStandard
        }
    }
}

