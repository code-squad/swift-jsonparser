//
//  InputView.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 12..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    func readInput(_ message: String) -> String {
        print(message)
        let input = readLine()
        guard let inputData = input else { return "" }
        return inputData
    }
    
}
