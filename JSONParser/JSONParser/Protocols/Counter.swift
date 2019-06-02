//
//  Counter.swift
//  JSONParser
//
//  Created by 이동영 on 02/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Counter {
    associatedtype T
    func count(target: T) -> Dictionary<String, Int>
}
