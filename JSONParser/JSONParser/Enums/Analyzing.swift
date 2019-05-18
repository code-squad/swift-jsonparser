//
//  Analyzing.swift
//  JSONParser
//
//  Created by 이동영 on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

typealias StartMark = Character
typealias EndMark = Character

enum Analyzing: StartMark {
    case Array = "["
    case Element = " "
    case String = "\""
    
    func isEnd(_ c: Character) -> Bool {
        var endMark: EndMark
        
        switch(self){
        case .Array:
            endMark = "]"
        case .Element:
            endMark = ","
        case .String:
            endMark = "\""
        }
        
        return c == endMark
    }
}
