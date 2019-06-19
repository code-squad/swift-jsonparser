//
//  Checker.swift
//  JSONParser
//
//  Created by 이동영 on 17/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Checker {
    associatedtype T
    
    func check(format: T) throws
}
