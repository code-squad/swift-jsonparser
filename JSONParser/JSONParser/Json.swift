//
//  Json.swift
//  JSONParser
//
//  Created by jang gukjin on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Json {
    var element: Json {get}
}

extension Bool: Json {
    var element: Json {
        get {
            return self
        }
    }
}

extension Int: Json {
    var element: Json {
        get {
            return self
        }
    }
}

extension String: Json {
    var element: Json {
        get {
            return self
        }
    }
}

extension Dictionary: Json{
    var element: Json {
        get {
            return self
        }
    }
}

extension Array: Json{
    var element: Json {
        get {
            return self
        }
    }
}
