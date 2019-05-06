//
//  ElementType.swift
//  JSONParser
//
//  Created by jang gukjin on 03/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol ElementType {
    init (json: String)
    func countType(jsonDatas: [Json]) -> Int
}
