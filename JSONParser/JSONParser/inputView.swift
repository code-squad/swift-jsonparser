//
//  InputView.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct InputView {
    static public func getInput(ment: String) -> String {
        print(ment)
        guard let input:String = readLine() else {
            return String()
        }
        return input
    }
}
