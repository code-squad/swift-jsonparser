//
//  ParsingTarget.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

protocol ParsingTarget {
    func count() -> Int
    func getEachValue(_ orderOfValue: Int) -> String

}
