//
//  OutputView.swift
//  JSONParser
//
//  Created by jang gukjin on 02/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    func printElements(elementType: ElementType, numberOfElements: Int, numberOfString: Int, numberOfInt: Int, numberOfBool: Int) {
        print("총 \(numberOfElements)개의 데이터 중에", terminator: "")
        print(" \(elementType.outputMent(number: numberOfString)),")
        print(" \(elementType.outputMent(number: numberOfInt)),")
        print(" \(elementType.outputMent(number: numberOfBool)),")
    }
}
