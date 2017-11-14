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
        if self.starts(with: "{") {
            result.append(self)
        } else {
            print("test")
            result.append(contentsOf: getElementsFromArray())
        }
        return result
    }
    
    func getElements() -> Array<String> {
        return self.split(separator: ",").flatMap {$0.trimmingCharacters(in: .whitespaces)}
    }
    
    private func getElementsFromArray() -> Array<String> {
        let checker = GrammarChecker()
        var elementsFromArray : Array<String> = []
        var elements : String = self.trimmingCharacters(in: ["[","]"])
        elementsFromArray.append(contentsOf: checker.getArrayMatches(from: elements))
        elements = checker.removeMatchedArray(target: elements)
        elementsFromArray.append(contentsOf: checker.getObjectMatches(from: elements))
        elements = checker.removeMatchedObject(target: elements)
        elementsFromArray.append(contentsOf: elements.getElements())
        return elementsFromArray
    }
    
    func getElementsForObject() -> Array<String> {
        return self.trimmingCharacters(in: ["{","}"]).split(separator: ",").flatMap {$0.trimmingCharacters(in: .whitespaces)}
    }
    
}
