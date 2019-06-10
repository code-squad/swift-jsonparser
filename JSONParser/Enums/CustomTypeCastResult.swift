//
//  CustomTypeCastResult.swift
//  JSONParser
//
//  Created by hw on 10/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum Result<T>{
    case castIntSuccess(T)
    case castBoolSuccess(T)
    case castStringSuccess(T)
}
