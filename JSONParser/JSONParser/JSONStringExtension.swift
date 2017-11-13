//
//  JSONStringExtension.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 8..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation


extension String {
    func getElementsAll() -> Array<String> {
        var result : Array<String> = []
        let objectGroups : Array<String> = self.trimmingCharacters(in: ["[","]"]).split(separator: "{").flatMap {$0.trimmingCharacters(in: .whitespaces)}
        for group in objectGroups {
            if !group.contains(":") {
                result.append(contentsOf: group.getElements())
                continue
            }
            result.append("{" + group.trimmingCharacters(in: [","]))
        }
        return result
    }
    
    func getElements() -> Array<String> {
        return self.split(separator: ",").flatMap {$0.trimmingCharacters(in: .whitespaces)}
    }
    
    func getElementsForObject() -> Array<String> {
        return self.trimmingCharacters(in: ["{","}"]).split(separator: ",").flatMap {$0.trimmingCharacters(in: .whitespaces)}
    }
    
}
