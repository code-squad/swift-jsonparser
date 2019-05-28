//
//  JsonParserable.swift
//  JSONParser
//
//  Created by jang gukjin on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JsonParserable {
    var arrayJson: [String] { get }
    var dictionaryJson: [String:String] { get }
}
