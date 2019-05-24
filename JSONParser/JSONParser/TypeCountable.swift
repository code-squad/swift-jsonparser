//
//  TypeCountable.swift
//  JSONParser
//
//  Created by Daheen Lee on 24/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol TypeCountable {
    var elementCount: Int { get }
    var elements: [JSONValue] { get }
}
