//
//  InputView.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct IntputView {
    static func read() -> String {
        guard let input = readLine() else {
            return ""
        }
        return input
    }
}
