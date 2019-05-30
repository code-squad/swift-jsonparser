//
//  TypeInt.swift
//  JSONParser
//
//  Created by jang gukjin on 03/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TypeInt: Json {
    private(set) var json : Int
    init<VariousType>(json: VariousType) {
        self.json = json as? Int ?? 0
    }
}
