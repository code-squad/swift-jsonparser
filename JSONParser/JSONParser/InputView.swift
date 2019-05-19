//
//  InputView.swift
//  JSONParser
//
//  Created by CHOMINJI on 13/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct InputView {
    
    static func readPrompt(for question: String) -> String {
        print(question)
        let prompt = readLine() ?? ""
        return prompt

    }
}
