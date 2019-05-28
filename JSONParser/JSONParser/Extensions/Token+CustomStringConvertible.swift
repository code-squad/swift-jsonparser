//
//  Token+CustomStringCovertable.swift
//  JSONParser
//
//  Created by 이동영 on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

extension Token: CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
}
