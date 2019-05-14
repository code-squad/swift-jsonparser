//
//  StringIndexs.swift
//  JSONParser
//
//  Created by jang gukjin on 15/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct StringIndexs {
    let startIndex = afterData.startIndex
    let afterStartIndex = afterData.index(after: afterData.startIndex)
    let endIndex = afterData.index(before: afterData.endIndex)
    let beforeEndIndex = afterData.index(afterData.endIndex, offsetBy: -2)
}
