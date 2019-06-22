//
//  ErrorHandler.swift
//  JSONParser
//
//  Created by 이동영 on 18/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct ErrorHandler {
    static func handle<IN,OUT> (input: IN, logic: (IN) throws -> (OUT), occur:(_ error: Error) -> Void = ErrorHandler.handle) -> OUT? {
        var result: OUT?
        do {
           result = try logic(input)
        }catch {
            handle(error)
        }
        return result
    }
    
    static private func handle(_ error: Error) {
        let outputView = OutputView()
        
        switch error {
        case let error as GrammerChecker.Error:
            outputView.output(error.localizedDescription)
        default:
            outputView.output(error.localizedDescription)
        }
    }
    
}

