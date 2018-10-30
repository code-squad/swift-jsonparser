//
//  extension.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

// 중복되는 코드를 extension을 이용해 묶음
extension String {
    mutating func removeBracket() -> String {
        return String(self.dropFirst().dropLast())
    }
    
    mutating func separateByComma() -> [String] {
        return self.split(separator: ",").map {String($0)}
    }
}
