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
        guard let input = InputView.read() else { return }
        let tokens = Tokenizer.parse(input)
        if let values = Formatter.isValid(tokens){
            OutputView.display(values)
        }else {
            print("지원하지 않는 형식이 포함되어 있습니다.")
        }
    }
}

Main.start()
