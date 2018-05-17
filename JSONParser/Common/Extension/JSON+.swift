//
//  JSON+.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 5. 17..
//  Copyright © 2018년 JK. All rights reserved.
//

extension JSON {
    func makeDepth(_ depth: Int) -> String {
        var depthForm: String = ""
        
        for _ in 0 ..< depth {
            depthForm += "\t"
        }
        
        return depthForm
    }
    
    func objectFormMaker(_ o: [String: Type], _ depth: Int = 0) -> String {
        
        var desription = "\(makeDepth(depth))\(TokenForm.openBrace.str)\n"
        
        for key in o.keys {
            let value = o[key]!
    
            switch value {
            case .number(let n):
                let value = makeDepth(depth + 1) + key + makeDepth(1) + TokenForm.colon.str + makeDepth(1) + String(n)
                desription += value
            case .string(let s):
                let value = makeDepth(depth + 1) + key + makeDepth(1) + TokenForm.colon.str + makeDepth(1) + s
                desription += value
            case .bool(let b):
                let value = key + makeDepth(1) + TokenForm.colon.str + makeDepth(1)  + String(b)
                desription += value
            case .object(let o):
                let value = makeDepth(depth + 1) + key + makeDepth(1) + TokenForm.colon.str + makeDepth(1) + objectFormMaker(o, depth + 1)
                desription += value
            case .array(let a):
                let value = makeDepth(depth + 1) + key + makeDepth(1) + TokenForm.colon.str + "\n"  + arrayFormMaker(a, depth + 1)
                desription += value
            }
            desription += "\n"
        }
        desription += makeDepth(depth)
        desription += TokenForm.closeBrace.str
        return desription
    }
    
    func arrayFormMaker(_ a: [Type], _ depth: Int = 0) -> String {
        
        var desription = makeDepth(depth) + "\(TokenForm.openBracket.str)\n"
        
        for element in a {
            desription += makeDepth(depth)
            switch element {
            case .string(let s):
                desription += makeDepth(depth + 1)
                desription += s
            case .bool(let b):
                desription += makeDepth(depth + 1)
                desription += String(b)
            case .number(let n):
                desription += makeDepth(depth + 1)
                desription += String(n)
            case .array(let a):
                desription += arrayFormMaker(a, depth + 1)
            case .object(let o):
                desription += objectFormMaker(o, depth + 1)
            }
            desription += "\n"
        }
        desription += makeDepth(depth)
        desription += "\(TokenForm.closeBracket.str)"
        
        return desription
    }
}
