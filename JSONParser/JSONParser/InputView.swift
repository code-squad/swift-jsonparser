//
//  InputView.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    func read() throws -> String? {
        let userRawData = readLine()
        do {
            return try JSONParser.check(userRawData)
        } catch ErrorCode.invalidJSONStandard {
            throw ErrorCode.invalidJSONStandard
        } catch ErrorCode.invalidInputString {
            throw ErrorCode.invalidInputString
        } catch {
            return nil
        }
    }
    
}

