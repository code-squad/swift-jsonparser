//
//  JSONTokenizer.swift
//  JSONParser
//
//  Created by JieunKim on 05/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONTokenizer {
    static func tokenize(data: String) -> [String] {
        return data.split(separator: ",").map { String($0) }
    }
}
