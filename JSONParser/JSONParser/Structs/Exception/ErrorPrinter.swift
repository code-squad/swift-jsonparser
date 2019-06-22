//
//  ErrorPrinter.swift
//  JSONParser
//
//  Created by 이동영 on 22/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct ErrorPrinter {
    
    static func print(_ error: Error) -> Void {
        switch error {
        case let exception as Exception:
            Swift.print(exception.description)
        default:
            Swift.print(error.localizedDescription)
        }
        
    }
}


