//
//  JSON.swift
//  JSONParser
//
//  Created by BLU on 2019. 6. 2..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

protocol JSONValue { }

extension String: JSONValue { }

extension Int: JSONValue { }

extension Bool: JSONValue { }
