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
        let readInput = readLine() ?? "[]"
        return readInput.getElementsAll()
    }
}
