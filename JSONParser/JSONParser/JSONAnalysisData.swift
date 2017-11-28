//
//  JSONAnalysis.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 28..
//  Copyright © 2017년 Napster. All rights reserved.
//

import Foundation

protocol JSONAnalysisData {
    var boolTypeCount: Int { get }
    var stringTypeCount: Int { get }
    var intTypeCount: Int { get }
    var objectTypeCount: Int { get }
    var arrayTypeCount: Int { get }
    var sumOfData: Int { get }
    mutating func countJSONData()
}
