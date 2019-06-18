//
//  SyntaxAnalyzer.swift
//  JSONParser
//
//  Created by JH on 08/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum ErrorMessage: Error {
    case grammarError
}

struct SyntaxAnalyzer {
    
    func analyzeSyntax(tokens: [String]) throws -> [String] {
        guard tokens[0] == "[" && tokens[tokens.count-1] == "]" else {
            throw ErrorMessage.grammarError
        }
        return tokens
    }
}


/*

 -------------------------------------------------------------
 1.input [ 이면 arraycharacter에 append
         " ", "," 이면 다음 index확인
 2. 다음 index가 " 이면 다시 " 나올때까지 arraystring에 append
 
 3. "없는 문자이면 ,과 " " 나올때까지 arr에 append
 4. arr이 Int로 변환되면 intarray에 append
 5. arr이 true거나 false이면 boolarray에 append
 --------------------------------------------------------------
 
 
 */


