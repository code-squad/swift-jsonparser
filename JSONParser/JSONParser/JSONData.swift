//
//  JSONData.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 28..
//  Copyright © 2017년 Napster. All rights reserved.
//

import Foundation

protocol JSONData {
    func analyzeData() -> JSONAnalysisData
    func countData() -> String
    func showJSONData(_ depth: Int) -> String
    static func lexData(_ value: String) throws -> [String]
    static func makeJSONData(_ value: [String]) throws -> JSONData
    static func makeJSONFirstObjectData(_ value: String) throws -> JSONData
}
