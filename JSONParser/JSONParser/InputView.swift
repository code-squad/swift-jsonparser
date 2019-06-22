//
//  InputView.swift
//  JSONParser
//
//  Created by JH on 22/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    func ask(data: String) -> String {
        print("\(data): ", terminator: "")
        return readLine() ?? ""
    }
}
