//
//  protocol.swift
//  JSONParser
//
//  Created by 김장수 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

protocol JSONData {
    func getDTO() -> DTO
}

protocol JSONArray: JSONData {
    
}

protocol JSONObject: JSONData {
    
}
