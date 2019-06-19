//
//  TypeAliases.swift
//  JSONParser
//
//  Created by 이동영 on 30/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation
// - MARK: - JSON
typealias JsonObject = [String: JsonValue]
typealias JsonList = [JsonValue]
// - MARK: - Parser
typealias ParsedResult = (value: JsonValue, parsedIndex: Int)

