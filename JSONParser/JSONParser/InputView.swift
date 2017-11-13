//
//  InputView.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    func readInput() throws -> Array<String> {
        let readInput = readLine() ?? "[]"
        try readInput.isJSONPattern()
        return readInput.getElementsAll()
    }
}
