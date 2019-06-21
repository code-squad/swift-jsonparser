//
//  ErrorHandler.swift
//  JSONParser
//
//  Created by 이동영 on 18/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct ErrorHandler {
    
    static func handle(error: Error) {
        let outputView = OutputView()
        
        switch error {
        case let error as GrammerChecker.Error:
            outputView.output(error.localizedDescription)
        default:
            outputView.output(error.localizedDescription)
        }
    }
}

