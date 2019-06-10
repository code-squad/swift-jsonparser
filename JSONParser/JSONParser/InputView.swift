//
//  InputView.swift
//  JSONParser
//
//  Created by 이희찬 on 03/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation
struct InputView {
    
    static func readInput(of massage:RequestMassage) -> String {
        
        print(massage.rawValue)
        return readLine() ?? ""
        
    }
    
}
