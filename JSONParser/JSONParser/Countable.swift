//
//  Countable.swift
//  JSONParser
//
//  Created by 이진영 on 21/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Countable: JsonType {
    var typeCount: [String : Int] { get }
}
