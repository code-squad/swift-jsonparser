//
//  Validator.swift
//  JSONParser
//
//  Created by 이희찬 on 03/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

typealias CountNumbers = (Int,Int,Int)

struct Validator {
    
    private var countNumber = CountNumber()
    
    mutating func checkDataType(convertedJSONArray:[String]) -> (Int,Int,Int) {
        
        for i in convertedJSONArray {
            if let convertedInt = Int(i){
                countNumber.countInt += 1
                continue
            }
            if let convertedBool = Bool(i){
                countNumber.countBool += 1
                continue
            }
            if FormatItem.DoubleQuotationMark.isStrictSubset(of: CharacterSet(charactersIn: i)) {
                countNumber.countString += 1
                continue
            }
        }
        return (countNumber.countInt,countNumber.countBool,countNumber.countString)
    }
}
