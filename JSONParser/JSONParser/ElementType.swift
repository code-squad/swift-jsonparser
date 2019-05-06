//
//  ElementType.swift
//  JSONParser
//
//  Created by jang gukjin on 03/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol ElementType {
    func outputMent(number: Int) -> (type: String, value: Int)
}
