//
//  ErrorHandler.swift
//  JSONParser
//
//  Created by 이동영 on 18/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct ErrorHandler {
    
    func handle(logic: () throws -> ()) {
        var occurError = false
        
        repeat {
            do {
                try logic()
                occurError = false
            }
            catch let error as GrammerChecker.Error {
                self.alertMessage(error.localizedDescription)
                occurError = true
            }
            catch {
                self.alertMessage(error.localizedDescription)
                occurError = true
            }
        } while occurError
    }
    
    private func alertMessage(_ message: String) {
        print("\n==============================")
        print("\t\(message)")
        print("==============================\n")
    }
}
