//
//  UsableType.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 13..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol ArrayUsableType {}
protocol ObjectUsableType {}

extension String : ArrayUsableType, ObjectUsableType {}
extension Double : ArrayUsableType, ObjectUsableType {}
extension Bool : ArrayUsableType, ObjectUsableType {}
extension Dictionary : ArrayUsableType {}
