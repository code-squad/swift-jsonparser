//
//  TokenConvertible.swift
//  JSONParser
//
//  Created by moon on 2018. 5. 2..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol TokenConvertible {
    func numberOfToken() -> Int
    func getToken(index: Int) -> String
}
