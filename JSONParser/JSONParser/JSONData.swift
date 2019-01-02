//
//  JSONData.swift
//  JSONParser
//
//  Created by Elena on 24/12/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct ObjectData{
    var objectCount: Int = 0
}

struct JSONData{
    var dataString = [String:String]()
    var dataInt = [String:Int]()
    var dataBool = [String:Bool]()
    var ObjectData:String = ""
}
