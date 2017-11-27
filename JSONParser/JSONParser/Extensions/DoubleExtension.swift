//
//  DoubleExtension.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 27..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

extension Double: JSONDataMaker {
    func makeJSONData() -> JSONData {
        return JSONData.number(self)
    }
}
