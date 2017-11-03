//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by yangpc on 2017. 11. 2..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    
    static func isJSONObjects(jsonString: String) -> Bool {
        let jsonObjectsRegularExpression = "\\[ (\\{ (((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))\\, )*((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))* \\}\\, )*\\{ (((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))\\, )*((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))* \\} \\]"
        return jsonString.isValid(with: jsonObjectsRegularExpression)
    }
    
    static func isJSONObject(jsonString: String) -> Bool {
        let jsonObjectRegularExpression = "\\{ (((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))\\, )*((\"[a-zA-Z]+\") \\: ([0-9]+|false|true|\"([a-zA-Z]+\\s)*[a-zA-Z]+\"))* \\}"
        return jsonString.isValid(with: jsonObjectRegularExpression)
    }
    
    static func isDatas(jsonString: String) -> Bool {
        let datasRegularExpression = "\\[ (([0-9]*|true|false|\"[0-9a-zA-Z]*\")*\\, )*([0-9]+|false|true|\"[0-9a-zA-Z]+\") \\]"
        return jsonString.isValid(with: datasRegularExpression)
    }
}

extension String{
    
    func isValid(with regularExpression: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regularExpression)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count)) != nil
        } catch let error {
            print(error.localizedDescription)
        }
        return false
    }
}

