//
//  OutputFile.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 21..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct OutputFile {
    private static var _name:String? = nil
    public static var name:String? {
        get{
            return _name
        }
        set(name){
            _name = name
        }
    }
}
