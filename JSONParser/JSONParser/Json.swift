//
//  Json.swift
//  JSONParser
//
//  Created by jang gukjin on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Json {}

extension Bool: Json {}

extension Int: Json {}

extension String: Json {}

extension Dictionary: Json{}
