//
//  Tokenizer.swift
//  JSONParser
//
//  Created by hw on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Tokenizer {
    static  func tokenize (_ input: String ) -> [String] {

        let lowerBound = String.Index.init(encodedOffset: 1)
        let uppderBound = String.Index.init(encodedOffset: input.count-1)
        let removeSquareBracketInput = input[lowerBound..<uppderBound]
        print (removeSquareBracketInput)
        let output = removeSquareBracketInput.split(separator: ",").map { (value) in return String(value).trimmingCharacters(in: .whitespacesAndNewlines)}

        
        return output
    }
}
