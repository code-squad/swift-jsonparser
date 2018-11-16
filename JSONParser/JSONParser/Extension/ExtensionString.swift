//
//  Extension.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String {
    func removeDoubleQuotationMarks() -> String {
        return trimmingCharacters(in: ["\"","\""])
    }
    
    func isTrue() -> Bool {
        return uppercased() == "TRUE"
    }
}
