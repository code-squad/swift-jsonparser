import Foundation

struct Parser {
    
    enum ParsingError: Error {
        case cannotFindSupportedType
        case objectKeyMustBeString
        case objectKeyMustBeOneAndOnly
    }
    
    static func parseString(_ input: String) -> String? {
        guard input.first == Token.quotationMark else { return nil }
        var input = input
        input.removeFirst()
        input.removeLast()
        return input
    }

    static func parseNumber(_ input: String) -> Number? {
        return Number(input)
    }
    
    static func parseBool(_ input: String) -> Bool? {
        switch input {
        case "true":
            return true
        case "false":
            return false
        default:
            return nil
        }
    }

    static func parseObject(_ input: String) throws -> [String: Type]? {
        guard input.first == Token.beginObject else { return nil }
        let tokenized = try ObjectTokenizer.tokenize(input)
        var result = [String: Type]()
        for (key, value) in tokenized {
            guard let key = parseString(key) else {
                throw ParsingError.objectKeyMustBeString
            }
            let value = try parseValue(value)
            result[key] = value
        }
        return result
    }

    static func parseArray(_ input: String) throws -> [Type]? {
        guard input.first == Token.beginArray else { return nil }
        let tokenized = try ArrayTokenizer.tokenize(input)
        var result = [Type]()
        for value in tokenized {
            result.append(try parseValue(value))
        }
        return result
    }
    
    static func parseValue(_ input: String) throws -> Type {
        if let string = parseString(input) { return string }
        else if let bool = parseBool(input) { return bool }
        else if let object = try parseObject(input) { return object }
        else if let array = try parseArray(input) { return array }
        else if let number = parseNumber(input) { return number }
        throw ParsingError.cannotFindSupportedType
    }

    

}
