//
//  Converter.swift
//  JSONParser
//
//  Created by 이희찬 on 03/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Converter {
    
    static func JSONToArray(JSON:String) -> [String] {
        var ConvertedJSONData = JSON.trimmingCharacters(in: FormatItem.JSONArray)
        ConvertedJSONData = ConvertedJSONData.split(separator: FormatItem.blank).joined()
        return ConvertedJSONData.components(separatedBy: FormatItem.arraySperator)
    }
    
}



