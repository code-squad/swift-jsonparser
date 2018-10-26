//
//  JSONDataForm.swift
//  JSONParser
//
//  Created by 윤지영 on 25/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol JSONDataForm {
    var typeName: String { get }
    var totalCount: Int { get }
    func countType() -> [String: Int]
}
