//
//  Extension.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 10. 30..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String {
    private func removeSquareBracket() -> String {
        return self.trimmingCharacters(in: ["[","]"])
    }
    
    private func removeSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    func extractData() -> [String] {
        let removedSquareBracket = self.removeSquareBracket()
        let removedSpace = removedSquareBracket.removeSpace()
        return removedSpace.split(separator: ",").map{String($0)}
    }
}
