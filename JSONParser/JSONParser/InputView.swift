//
//  InputView.swift
//  JSONParser
//
//  Created by BLU on 2019. 5. 28..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    func readText() -> String {
        return readLine() ?? ""
    }
}
