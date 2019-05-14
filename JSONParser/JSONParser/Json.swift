//
//  Json.swift
//  JSONParser
//
//  Created by jang gukjin on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Json {
    init (json: String) throws
    /// [Json]타입의 배열을 받아 해당 배열에 해당 타입이 얼마나 있는지 갯수를 파악하는 함수
    func countType(jsonDatum: Json) -> String
}
