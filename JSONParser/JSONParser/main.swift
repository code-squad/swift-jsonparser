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
            print("지원하지 않는 형식을 포함하고 있습니다.")
            return
        }
        let result = JSONParser.result(from: input)
        OutputView.display(from: result)
    }
}

Main.start()
