//
//  Converter.swift
//  JSONParser
//
//  Created by 이희찬 on 03/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Converter {
    
    static func convertToArray(JSON:String) -> [String] {
        
        let removedJSONArrayFormatInput = JSON.trimmingCharacters(in: FormatItem.JSONArrayFormat)
        let removedblankInput = removedJSONArrayFormatInput.split(separator: FormatItem.blank).joined()
        return removedblankInput.components(separatedBy: FormatItem.arraySperator)
        
    }
    
}



