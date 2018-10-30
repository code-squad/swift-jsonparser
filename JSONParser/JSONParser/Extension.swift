//
//  Extension.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String {
    func removeSquareBracket() -> String {
        return self.trimmingCharacters(in: ["[","]"])
    }
    
    func removeSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}
