//
//  BoolExtension.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 27..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

extension Bool: JSONDataMaker {
    func makeJSONData() -> JSONData {
        return JSONData.bool(self)
    }
}
