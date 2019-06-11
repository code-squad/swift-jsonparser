//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

struct JSONAnalyzer{
    static func run() {
        var errorOccurred: Bool = false
        repeat{
            do{
                let inputView = InputView()
                let userInput = inputView.run()
                var tokenizer = MyTokenizer.init(userInput)
                let tokens = try tokenizer.tokenize()
                print(tokens)
                var parser = JsonParser.init(tokens: tokens)
                let jsonValue = parser.parse()
                var outputView = OutputView.init(jsonValue)
                outputView.run()
                errorOccurred = false
            }catch {
                errorOccurred = true
                print(error)
            }
        }while errorOccurred
    }
}

JSONAnalyzer.run()
//enum JSONValue {
//    case string(String)
//    case int(Int)
//    case double(Double)
//    case bool(Bool)
//    case object([String: JSONValue])
//    case array([JSONValue])
//}
//
//extension JSONValue: ExpressibleByStringLiteral {
//    public init(stringLiteral value: String) {
//        self = .string(value)
//    }
//}
//
//extension JSONValue: ExpressibleByIntegerLiteral {
//    public init(integerLiteral value: Int) {
//        self = .int(value)
//    }
//}
//
//extension JSONValue: ExpressibleByFloatLiteral {
//    public init(floatLiteral value: Double) {
//        self = .double(value)
//    }
//}
//
//extension JSONValue: ExpressibleByBooleanLiteral {
//    public init(booleanLiteral value: Bool) {
//        self = .bool(value)
//    }
//}
//
//extension JSONValue: ExpressibleByArrayLiteral {
//    public init(arrayLiteral elements: JSONValue...) {
//        self = .array(elements)
//    }
//}
//
//extension JSONValue: ExpressibleByDictionaryLiteral {
//    public init(dictionaryLiteral elements: (String, JSONValue)...) {
//        self = .object([String: JSONValue](uniqueKeysWithValues: elements))
//    }
//}
//
