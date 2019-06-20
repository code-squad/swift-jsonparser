//
//  TokenGenerater.swift
//  JSONParserTests
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Factory {
    associatedtype T
    
    func create(string: String) -> T?
}
