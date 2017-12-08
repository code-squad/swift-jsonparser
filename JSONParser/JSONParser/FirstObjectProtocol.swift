//
//   FirstObjectProtocol.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

protocol FirstObject {
    var type: String { get }
    func checkJsonSyntax(token: [Token], stack: JsonStack)
}
