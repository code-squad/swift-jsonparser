//
//  ErrorHandler.swift
//  JSONParser
//
//  Created by 이동영 on 18/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct ErrorHandler {
    let handleAction: (_ error: Error) -> Void
    
    init (handleAction: @escaping (_ error: Error) -> Void) {
        self.handleAction = handleAction
    }
    
    func handle(logic: () throws -> Void ) {
        do {
            try logic()
        }catch {
            handleAction(error)
            exit(0)
        }
        
    }
}
