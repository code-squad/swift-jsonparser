//
//  InputView.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 19..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    func readInput() -> String {
        let userJson = readLine()
        guard let input = userJson else {
            return ""
        }
        return input
    }
    
}

