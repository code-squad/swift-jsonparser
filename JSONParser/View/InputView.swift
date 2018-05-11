//
//  InputView.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

struct InputView {
    static func readInput() throws -> String {
        guard let readInput = readLine() else {
            throw JsonError.isNil
        }
        return readInput
    }
}
