//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

struct Main {
    static func start(){
        guard let input = InputView.read() else {
            print("올바르지 않은 형식입니다.")
            return
        }
        let result = JSONParser.result(from: input)
        OutputView.display(from: result)
    }
}

Main.start()
