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
        var endMarks = [EndMark]()
        
        switch (self){
        case .String:
            endMarks.append("\"")
        case .Element:
            endMarks.append(",")
            fallthrough
        case .Array:
            endMarks.append("]")
        }
        
        return endMarks.contains(c)
    }
    
    func isStart(_ c: Character) -> Bool {
        var availableStartMarks = [StartMark]()
        
        switch (self){
        case .Array,.Element:
            availableStartMarks.append(Analyzing.Element.rawValue)
            availableStartMarks.append(Analyzing.String.rawValue)
            availableStartMarks.append(Analyzing.Array.rawValue)
        case .String:
            ()
        }
        return availableStartMarks.contains(c)
    }
    
}
